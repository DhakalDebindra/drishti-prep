import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { useAttemptStore } from "@/features/practice/store/attempt-store";

                export function ConfirmSubmitDialog() {
                  const {
                    state: { showConfirmDialog },
                    derived: { answeredCount, unansweredCount },
                    actions: { setShowConfirmDialog, submitPracticeSet },
                       } = useAttemptStore();

                  return (
                    <Dialog open={showConfirmDialog} onOpenChange={(open) => setShowConfirmDialog(open)}>
                        <DialogContent className="sm:max-w-[425px]">
                          <DialogHeader>
                          <DialogTitle>Confirm Submission</DialogTitle>
                          <DialogDescription>
                            You have answered {answeredCount} question{answeredCount === 1 ? "" : "s"}. The remaining {unansweredCount} will be marked as skipped. Are you ready to submit?
                          </DialogDescription>
                        </DialogHeader>
                        <DialogFooter className="mt-4 flex flex-col gap-2 sm:flex-row sm:justify-end">
                          <Button variant="outline" onClick={() => setShowConfirmDialog(false)}>
                            Cancel
                          </Button>
                              <Button onClick={submitPracticeSet}>
                              Confirm and Submit
                            </Button>
                        </DialogFooter>
                      </DialogContent>
                    </Dialog>
                  );
                }
