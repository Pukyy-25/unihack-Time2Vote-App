import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Link } from "react-router-dom";
import { Vote, Shield, MapPin, Users, TrendingUp, CheckCircle2 } from "lucide-react";

const Index = () => {
  return (
    <div className="min-h-screen bg-background">
      {/* Hero Section */}
      <section className="relative overflow-hidden">
        <div 
          className="absolute inset-0 opacity-10"
          style={{ background: 'var(--gradient-hero)' }}
        />
        <div className="container mx-auto px-4 py-20 relative">
          <div className="max-w-3xl mx-auto text-center space-y-8">
            <Badge variant="secondary" className="mb-4">
              Democracy in Your Pocket
            </Badge>
            <h1 className="text-5xl md:text-6xl font-bold text-foreground leading-tight">
              Make Your Voice Heard on Local Issues
            </h1>
            <p className="text-xl text-muted-foreground">
              Time2Vote brings civic engagement to the digital age. Vote on community initiatives, 
              stay informed about local projects, and help shape your neighborhood's future.
            </p>
            <div className="flex gap-4 justify-center flex-wrap">
              <Link to="/initiatives">
                <Button size="lg" className="text-lg px-8">
                  <Vote className="mr-2 h-5 w-5" />
                  Browse Initiatives
                </Button>
              </Link>
              <Button size="lg" variant="outline" className="text-lg px-8">
                Learn More
              </Button>
            </div>
            
            {/* Stats */}
            <div className="grid grid-cols-3 gap-8 pt-12 max-w-2xl mx-auto">
              <div className="text-center">
                <div className="text-3xl font-bold text-primary">42K+</div>
                <div className="text-sm text-muted-foreground">Active Voters</div>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-secondary">156</div>
                <div className="text-sm text-muted-foreground">Active Initiatives</div>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-accent">89%</div>
                <div className="text-sm text-muted-foreground">Participation Rate</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 bg-muted/30">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-foreground mb-4">
              Why Time2Vote?
            </h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              We're building trust between citizens and local authorities through transparency and accessibility
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto">
            <Card className="p-8 text-center space-y-4 bg-gradient-to-b from-card to-card/50">
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto">
                <Vote className="h-8 w-8 text-primary" />
              </div>
              <h3 className="text-2xl font-bold text-foreground">Real-Time Voting</h3>
              <p className="text-muted-foreground">
                Cast your vote on community initiatives instantly and see results in real-time
              </p>
            </Card>

            <Card className="p-8 text-center space-y-4 bg-gradient-to-b from-card to-card/50">
              <div className="w-16 h-16 bg-secondary/10 rounded-full flex items-center justify-center mx-auto">
                <MapPin className="h-8 w-8 text-secondary" />
              </div>
              <h3 className="text-2xl font-bold text-foreground">Local Focus</h3>
              <p className="text-muted-foreground">
                See initiatives in your area with map integration and location-based filtering
              </p>
            </Card>

            <Card className="p-8 text-center space-y-4 bg-gradient-to-b from-card to-card/50">
              <div className="w-16 h-16 bg-accent/10 rounded-full flex items-center justify-center mx-auto">
                <Shield className="h-8 w-8 text-accent" />
              </div>
              <h3 className="text-2xl font-bold text-foreground">Secure & Transparent</h3>
              <p className="text-muted-foreground">
                Your vote is secure, anonymous, and contributes to a transparent democratic process
              </p>
            </Card>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="py-20">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-foreground mb-4">
              How It Works
            </h2>
            <p className="text-xl text-muted-foreground">
              Three simple steps to make your voice heard
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-12 max-w-5xl mx-auto">
            <div className="text-center space-y-4">
              <div className="w-20 h-20 bg-primary text-primary-foreground rounded-full flex items-center justify-center mx-auto text-3xl font-bold">
                1
              </div>
              <h3 className="text-xl font-bold text-foreground">Browse Initiatives</h3>
              <p className="text-muted-foreground">
                Explore active community projects and proposals in your area
              </p>
            </div>

            <div className="text-center space-y-4">
              <div className="w-20 h-20 bg-secondary text-secondary-foreground rounded-full flex items-center justify-center mx-auto text-3xl font-bold">
                2
              </div>
              <h3 className="text-xl font-bold text-foreground">Learn & Discuss</h3>
              <p className="text-muted-foreground">
                Read detailed information about each initiative and its impact
              </p>
            </div>

            <div className="text-center space-y-4">
              <div className="w-20 h-20 bg-accent text-accent-foreground rounded-full flex items-center justify-center mx-auto text-3xl font-bold">
                3
              </div>
              <h3 className="text-xl font-bold text-foreground">Cast Your Vote</h3>
              <p className="text-muted-foreground">
                Vote yes or no and see real-time results from your community
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-primary text-primary-foreground">
        <div className="container mx-auto px-4 text-center">
          <div className="max-w-3xl mx-auto space-y-8">
            <h2 className="text-4xl md:text-5xl font-bold">
              Ready to Shape Your Community?
            </h2>
            <p className="text-xl opacity-90">
              Join thousands of engaged citizens making a difference in their neighborhoods
            </p>
            <div className="flex gap-4 justify-center flex-wrap">
              <Link to="/initiatives">
                <Button size="lg" variant="secondary" className="text-lg px-8">
                  Start Voting Now
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-border bg-card py-12">
        <div className="container mx-auto px-4">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <div className="flex items-center gap-2">
              <Vote className="h-6 w-6 text-primary" />
              <span className="text-xl font-bold text-foreground">Time2Vote</span>
            </div>
            <div className="text-sm text-muted-foreground">
              © 2025 Time2Vote. Empowering communities through digital democracy.
            </div>
            <div className="flex gap-6">
              <a href="#" className="text-sm text-muted-foreground hover:text-primary transition-colors">
                About
              </a>
              <a href="#" className="text-sm text-muted-foreground hover:text-primary transition-colors">
                Privacy
              </a>
              <a href="#" className="text-sm text-muted-foreground hover:text-primary transition-colors">
                Terms
              </a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Index;
