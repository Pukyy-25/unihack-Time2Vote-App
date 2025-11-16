import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Card } from "@/components/ui/card";
import { MessageSquare } from "lucide-react";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useQuery } from "@tanstack/react-query";
import { Comment } from "./Comment";

interface InitiativeCommentsProps {
  initiativeId: string;
}

export const InitiativeComments = ({ initiativeId }: InitiativeCommentsProps) => {
  const [newComment, setNewComment] = useState("");

  // Fetch top-level comments (no parent)
  const { data: comments, refetch } = useQuery({
    queryKey: ['initiativeComments', initiativeId],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('initiative_comments')
        .select('*')
        .eq('initiative_id', initiativeId)
        .is('parent_comment_id', null)
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data;
    },
    enabled: !!initiativeId
  });

  const handleSubmitComment = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      toast.error("Trebuie să fii autentificat pentru a comenta");
      return;
    }

    if (!newComment.trim()) {
      toast.error("Te rog scrie un comentariu");
      return;
    }

    try {
      // Check content with Gemini AI
      const geminiApiKey = import.meta.env.VITE_GEMINI_API_KEY;
      if (!geminiApiKey) {
        toast.error("API key not configured");
        return;
      }

      const geminiResponse = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${geminiApiKey}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{
              parts: [{
                text: `You are a content moderator for a civic discussion forum from Romania. Analyze the following comment for profanity, vulgar language, insults, hate speech, or inappropriate content in both Romanian and English.

Comment to analyze: "${newComment.trim()}"

Respond with ONLY one word:
- "SAFE" if the comment is respectful and contains NO profanity, vulgar language, insults, or any inappropriate content in either Romanian or English.
- "BLOCKED" if the comment contains ANY inappropriate language, swearing, insults, hate speech, or vulgar content in either Romanian or English, regardless of intensity.

Be very strict - block ANY comment that could be considered offensive or inappropriate.`
              }]
            }],
            safetySettings: [
              { category: 'HARM_CATEGORY_HARASSMENT', threshold: 'BLOCK_LOW_AND_ABOVE' },
              { category: 'HARM_CATEGORY_HATE_SPEECH', threshold: 'BLOCK_LOW_AND_ABOVE' },
              { category: 'HARM_CATEGORY_SEXUALLY_EXPLICIT', threshold: 'BLOCK_LOW_AND_ABOVE' },
              { category: 'HARM_CATEGORY_DANGEROUS_CONTENT', threshold: 'BLOCK_LOW_AND_ABOVE' }
            ]
          })
        }
      );

      const geminiData = await geminiResponse.json();
      
      // Check if Gemini blocked it
      if (geminiData.promptFeedback?.blockReason) {
        toast.error("Comentariul tău a fost blocat din cauza conținutului inadecvat");
        return;
      }

      const geminiText = geminiData.candidates?.[0]?.content?.parts?.[0]?.text || '';
      if (geminiText.includes('BLOCKED')) {
        toast.error("Comentariul tău conține limbaj inadecvat. Te rugăm să fii respectuos.");
        return;
      }

      // If safe, insert into database
      const { error } = await supabase.from('initiative_comments').insert({
        initiative_id: initiativeId,
        user_id: user.id,
        content: newComment.trim()
      });

      if (error) throw error;

      toast.success("Comentariu adăugat cu succes!");
      setNewComment("");
      refetch();
    } catch (error) {
      console.error("Error adding comment:", error);
      toast.error("A apărut o eroare la adăugarea comentariului");
    }
  };

  return (
    <section className="mt-8">
      <h2 className="text-2xl font-bold text-white mb-4 flex items-center gap-2">
        <MessageSquare className="h-6 w-6" />
        Discuții ({comments?.length || 0})
      </h2>

      {/* Add new comment */}
      <Card className="p-6 mb-6" style={{ backgroundColor: '#EDEDB3' }}>
        <h3 className="text-lg font-semibold text-foreground mb-3">Adaugă un comentariu</h3>
        <Textarea
          value={newComment}
          onChange={(e) => setNewComment(e.target.value)}
          placeholder="Scrie comentariul tău aici..."
          className="min-h-[120px] mb-3"
        />
        <Button onClick={handleSubmitComment}>
          Publică comentariu
        </Button>
      </Card>

      {/* Display comments */}
      <div className="space-y-4">
        {comments && comments.length > 0 ? (
          comments.map((comment) => (
            <Comment
              key={comment.id}
              comment={comment}
              initiativeId={initiativeId}
              onReplyAdded={refetch}
            />
          ))
        ) : (
          <Card className="p-8 text-center">
            <p className="text-muted-foreground">
              Nu există comentarii încă. Fii primul care comentează!
            </p>
          </Card>
        )}
      </div>
    </section>
  );
};
