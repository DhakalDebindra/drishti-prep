import React from "react";
import Link from "next/link";
import { PlayCircle, Bookmark } from "lucide-react";

interface SetInfo {
  title: string;
  topic: {
    name: string;
    subject: {
      name: string;
    };
  };
}

interface AttemptWithSet {
  id: string;
  status: string;
  question_sets: SetInfo | null;
}

export function PracticeBanners({ attempts }: { attempts: AttemptWithSet[] }) {
  const inProgressAttempt = attempts.find((a) => a.status === "in_progress");

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
      {inProgressAttempt && inProgressAttempt.question_sets ? (
        <div className="bg-gradient-to-br from-indigo-500 to-purple-600 rounded-2xl p-6 shadow-md text-white flex flex-col justify-between items-start gap-4">
          <div>
            <div className="text-indigo-100 text-sm font-medium mb-1">
              Resume Practice
            </div>
            <h3 className="text-xl font-bold">
              {inProgressAttempt.question_sets.title}
            </h3>
            <p className="text-indigo-100 text-sm">
              {inProgressAttempt.question_sets.topic.subject.name} &bull;{" "}
              {inProgressAttempt.question_sets.topic.name}
            </p>
          </div>
          <Link
            href={`/practice/${inProgressAttempt.question_sets.topic.subject.name.toLowerCase()}/${inProgressAttempt.question_sets.topic.name.toLowerCase()}/${inProgressAttempt.question_sets.title.toLowerCase()}`}
            className="inline-flex items-center bg-white text-indigo-600 hover:bg-indigo-50 font-medium px-4 py-2 rounded-lg transition-colors text-sm"
          >
            <PlayCircle className="w-4 h-4 mr-2" />
            Continue Set
          </Link>
        </div>
      ) : (
        <div className="bg-slate-100 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 flex flex-col justify-center items-center text-center gap-2">
          <div className="text-slate-500 dark:text-slate-400">
            No active practice sets.
          </div>
          <Link
             href="/practice"
             className="text-blue-600 dark:text-blue-400 hover:underline font-medium text-sm"
          >
             Browse available sets
          </Link>
        </div>
      )}

      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 shadow-sm flex flex-col justify-between items-start gap-4">
        <div>
          <div className="flex items-center gap-2 text-slate-800 dark:text-slate-200 mb-1">
            <Bookmark className="w-5 h-5 text-blue-500" />
            <span className="font-bold text-lg">My Bookmarks</span>
          </div>
          <p className="text-slate-500 dark:text-slate-400 text-sm leading-relaxed">
            Review questions you found challenging or want to memorize.
          </p>
        </div>
        <Link
          href="/bookmarks"
          className="inline-flex items-center text-sm font-medium bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 text-slate-900 dark:text-white px-4 py-2 rounded-lg transition-colors"
        >
          View Bookmarks
        </Link>
      </div>
    </div>
  );
}
