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

  // Rendered only while open, rather than passing `open={showConfirmDialog}`
  // to an always-mounted Dialog: this page re-renders frequently enough
  // (attempt state, tutor hooks, etc.) that Base UI's close animation kept
  // restarting mid-flight and never reached its end event, leaving the
  // dialog stuck fully visible and screen-blocking after Cancel. Mounting
  // only while open forces an immediate, reliable unmount -- no close
  // animation, but a stuck-forever modal is a worse trade.
  if (!showConfirmDialog) return null;

  return (
    <Dialog open onOpenChange={(open) => setShowConfirmDialog(open)}>
      <DialogContent className="sm:max-w-[460px] rounded-3xl border border-slate-200 bg-white shadow-xl dark:border-slate-800 dark:bg-slate-950">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold tracking-tight text-slate-950 dark:text-white">
            Confirm submission
          </DialogTitle>
          <DialogDescription className="text-slate-600 dark:text-slate-300">
            You have answered {answeredCount} question{answeredCount === 1 ? "" : "s"}. The remaining {unansweredCount} will be marked as skipped. Are you ready to submit?
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="mt-4 flex flex-col gap-2 sm:flex-row sm:justify-end">
          <Button
            variant="outline"
            onClick={() => setShowConfirmDialog(false)}
            className="rounded-full border-slate-200 bg-white text-slate-700 hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200 dark:hover:bg-slate-900"
          >
            Cancel
          </Button>
          <Button
            variant="default"
            onClick={submitPracticeSet}
            className="rounded-full bg-primary shadow-md shadow-primary/20 transition hover:bg-primary/90"
          >
            Confirm and submit
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
