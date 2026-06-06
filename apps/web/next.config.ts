import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  transpilePackages: [
    "@repo/supabase",
    "@repo/types",
    "@repo/utils",
    "@repo/validation",
  ],
  serverExternalPackages: ["ffmpeg-static"],
};

export default nextConfig;
