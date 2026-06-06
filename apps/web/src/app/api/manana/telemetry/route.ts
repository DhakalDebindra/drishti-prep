import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';

export async function POST(req: Request) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  try {
    const { episode_id, listen_duration_seconds, completed } = await req.json();

    if (!episode_id) {
      return NextResponse.json({ error: 'Missing episode_id' }, { status: 400 });
    }

    const { data: existing } = await (supabase as any)
      .from('manana_episode_plays')
      .select('id')
      .eq('episode_id', episode_id)
      .eq('user_id', user.id)
      .maybeSingle();

    if (existing) {
      const { error } = await (supabase as any)
        .from('manana_episode_plays')
        .update({
          reached_ms: listen_duration_seconds * 1000,
          completed,
          updated_at: new Date().toISOString()
        })
        .eq('id', existing.id);
        
      if (error) {
        console.error('Error updating manana_episode_plays:', error);
        return NextResponse.json({ error: 'Failed to update telemetry' }, { status: 500 });
      }
    } else {
      const { error } = await (supabase as any)
        .from('manana_episode_plays')
        .insert({
          episode_id,
          user_id: user.id,
          reached_ms: listen_duration_seconds * 1000,
          completed
        });
        
      if (error) {
        console.error('Error inserting manana_episode_plays:', error);
        return NextResponse.json({ error: 'Failed to insert telemetry' }, { status: 500 });
      }
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error parsing telemetry payload:', error);
    return NextResponse.json({ error: 'Invalid payload' }, { status: 400 });
  }
}
