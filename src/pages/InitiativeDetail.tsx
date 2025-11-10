import { useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Separator } from "@/components/ui/separator";
import { ArrowLeft, MapPin, Clock, Users, ThumbsUp, ThumbsDown, CheckCircle2 } from "lucide-react";
import { toast } from "sonner";

const mockInitiative = {
  id: 1,
  title: "New Community Park Development",
  description: "This proposal aims to develop a new 5-acre community park in the downtown area. The park will feature modern playgrounds, walking trails, green spaces, and community gathering areas. This initiative will provide residents with accessible outdoor recreation space and enhance the quality of life in our neighborhood.",
  fullDetails: "The proposed community park will be located at the intersection of Main Street and Oak Avenue, currently an unused lot. The development plan includes:\n\n• Two modern playgrounds (one for ages 2-5, one for ages 6-12)\n• 1.5 miles of paved walking and biking trails\n• Open green spaces for picnics and recreation\n• Community pavilion with seating for 100 people\n• Sustainable landscaping with native plants\n• Solar-powered lighting throughout the park\n• Accessible paths and facilities for all abilities\n\nEstimated budget: $2.4 million\nTimeline: 18 months from approval\nMaintenance: Funded through Parks Department annual budget",
  category: "Infrastructure",
  location: "Downtown District - Main St & Oak Ave",
  votesFor: 2847,
  votesAgainst: 432,
  daysLeft: 12,
  totalDays: 30,
  status: "active",
  sponsor: "Downtown Community Association",
  datePosted: "November 28, 2025"
};

const InitiativeDetail = () => {
  const { id } = useParams();
  const [hasVoted, setHasVoted] = useState(false);
  const [userVote, setUserVote] = useState<"yes" | "no" | null>(null);

  const totalVotes = mockInitiative.votesFor + mockInitiative.votesAgainst;
  const votePercentage = Math.round((mockInitiative.votesFor / totalVotes) * 100);
  const daysProgress = ((mockInitiative.totalDays - mockInitiative.daysLeft) / mockInitiative.totalDays) * 100;

  const handleVote = (vote: "yes" | "no") => {
    setHasVoted(true);
    setUserVote(vote);
    toast.success(
      vote === "yes" ? "You voted in support!" : "You voted against!",
      {
        description: "Your vote has been recorded securely.",
      }
    );
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="border-b border-border bg-card">
        <div className="container mx-auto px-4 py-4">
          <Link to="/initiatives" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft className="h-5 w-5" />
            <span className="font-semibold">Back to Initiatives</span>
          </Link>
        </div>
      </header>

      <main className="container mx-auto px-4 py-8 max-w-4xl">
        {/* Title & Category */}
        <div className="space-y-4 mb-8">
          <div className="flex items-start gap-3 flex-wrap">
            <Badge variant="secondary">{mockInitiative.category}</Badge>
            <Badge variant="outline" className="gap-1">
              <Clock className="h-3 w-3" />
              {mockInitiative.daysLeft} days remaining
            </Badge>
          </div>
          <h1 className="text-4xl font-bold text-foreground">{mockInitiative.title}</h1>
          <div className="flex items-center gap-2 text-muted-foreground">
            <MapPin className="h-4 w-4" />
            <span>{mockInitiative.location}</span>
          </div>
        </div>

        {/* Vote Card */}
        <Card className="p-6 mb-8 bg-gradient-to-br from-card to-muted/20">
          <div className="space-y-6">
            {/* Vote Stats */}
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <Users className="h-5 w-5 text-muted-foreground" />
                  <span className="text-2xl font-bold">{totalVotes.toLocaleString()}</span>
                  <span className="text-muted-foreground">total votes</span>
                </div>
                <div className="text-right">
                  <div className="text-3xl font-bold text-vote-yes">{votePercentage}%</div>
                  <div className="text-sm text-muted-foreground">in support</div>
                </div>
              </div>

              <div className="space-y-2">
                <Progress value={votePercentage} className="h-3" />
                <div className="flex justify-between text-sm">
                  <span className="text-vote-yes font-medium">{mockInitiative.votesFor.toLocaleString()} Yes</span>
                  <span className="text-vote-no font-medium">{mockInitiative.votesAgainst.toLocaleString()} No</span>
                </div>
              </div>
            </div>

            <Separator />

            {/* Voting Buttons */}
            {!hasVoted ? (
              <div className="space-y-3">
                <p className="text-center font-medium">Cast your vote on this initiative</p>
                <div className="grid grid-cols-2 gap-4">
                  <Button
                    size="lg"
                    className="bg-vote-yes hover:bg-vote-yes/90 text-white"
                    onClick={() => handleVote("yes")}
                  >
                    <ThumbsUp className="h-5 w-5 mr-2" />
                    Vote Yes
                  </Button>
                  <Button
                    size="lg"
                    variant="outline"
                    className="border-vote-no text-vote-no hover:bg-vote-no hover:text-white"
                    onClick={() => handleVote("no")}
                  >
                    <ThumbsDown className="h-5 w-5 mr-2" />
                    Vote No
                  </Button>
                </div>
              </div>
            ) : (
              <div className="text-center space-y-2">
                <div className="flex items-center justify-center gap-2 text-success">
                  <CheckCircle2 className="h-6 w-6" />
                  <span className="font-semibold text-lg">
                    You voted {userVote === "yes" ? "Yes" : "No"}
                  </span>
                </div>
                <p className="text-sm text-muted-foreground">Your vote has been recorded</p>
              </div>
            )}

            {/* Time Progress */}
            <div className="space-y-2 pt-2">
              <div className="flex justify-between text-sm text-muted-foreground">
                <span>Voting period</span>
                <span>{mockInitiative.daysLeft} of {mockInitiative.totalDays} days left</span>
              </div>
              <Progress value={daysProgress} className="h-1.5" />
            </div>
          </div>
        </Card>

        {/* Details Section */}
        <div className="space-y-6">
          <Card className="p-6">
            <h2 className="text-2xl font-bold mb-4">Overview</h2>
            <p className="text-foreground leading-relaxed">{mockInitiative.description}</p>
          </Card>

          <Card className="p-6">
            <h2 className="text-2xl font-bold mb-4">Full Details</h2>
            <div className="text-foreground leading-relaxed whitespace-pre-line">
              {mockInitiative.fullDetails}
            </div>
          </Card>

          <Card className="p-6">
            <h2 className="text-2xl font-bold mb-4">Initiative Information</h2>
            <div className="space-y-3 text-foreground">
              <div className="flex justify-between">
                <span className="text-muted-foreground">Sponsored by:</span>
                <span className="font-medium">{mockInitiative.sponsor}</span>
              </div>
              <Separator />
              <div className="flex justify-between">
                <span className="text-muted-foreground">Date posted:</span>
                <span className="font-medium">{mockInitiative.datePosted}</span>
              </div>
              <Separator />
              <div className="flex justify-between">
                <span className="text-muted-foreground">Status:</span>
                <Badge>{mockInitiative.status}</Badge>
              </div>
            </div>
          </Card>
        </div>
      </main>
    </div>
  );
};

export default InitiativeDetail;
