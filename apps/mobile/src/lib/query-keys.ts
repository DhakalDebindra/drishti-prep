export const queryKeys = {
  profile: {
    all: ['profile'] as const,
    detail: (userId: string) => ['profile', userId] as const,
  },
  attempts: {
    all: ['attempts'] as const,
    list: (userId: string) => ['attempts', userId] as const,
    detail: (attemptId: string) => ['attempts', attemptId] as const,
  },
  enrollments: {
    all: ['enrollments'] as const,
    list: (userId: string) => ['enrollments', userId] as const,
  },
  modules: {
    all: ['modules'] as const,
    list: () => ['modules'] as const,
    detail: (slug: string) => ['modules', slug] as const,
  },
  subjects: {
    all: ['subjects'] as const,
    list: (moduleId: string) => ['subjects', moduleId] as const,
  },
  questionSets: {
    all: ['question-sets'] as const,
    list: (topicId: string) => ['question-sets', topicId] as const,
    detail: (setId: string) => ['question-sets', setId] as const,
  },
  questions: {
    all: ['questions'] as const,
    list: (setId: string) => ['questions', setId] as const,
  },
  bookmarks: {
    all: ['bookmarks'] as const,
    list: (userId: string, page: number) => ['bookmarks', userId, page] as const,
  },
  memoryHeat: {
    all: ['memory-heat'] as const,
    detail: (userId: string) => ['memory-heat', userId] as const,
  },
  courses: {
    all: ['courses'] as const,
    list: (userId: string) => ['courses', userId] as const,
    detail: (moduleSlug: string) => ['courses', 'detail', moduleSlug] as const,
  },
  practice: {
    modules: () => ['practice', 'modules'] as const,
    subjects: (moduleId: string) => ['practice', 'subjects', moduleId] as const,
    sets: (topicId: string) => ['practice', 'sets', topicId] as const,
    session: (setId: string) => ['practice', 'session', setId] as const,
    active: (userId: string, setId: string) => ['practice', 'active', userId, setId] as const,
    review: (attemptId: string) => ['practice', 'review', attemptId] as const,
  },
}
