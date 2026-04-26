export type UserProfile = {
  id: string;
  full_name: string | null;
  is_admin: boolean | null;
  xp_points: number;
  current_streak: number;
  best_streak: number;
  created_at: string;
};
