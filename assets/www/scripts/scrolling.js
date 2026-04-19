const _scrollRoot =
  document.documentElement.scrollHeight > document.body.scrollHeight
      ? document.documentElement
      : document.body;

function scrollableHeight(element) {
  return element.scrollHeight - element.clientHeight;
}

function scrollToProgress(progress) {
  const target = progress * scrollableHeight(_scrollRoot);
  _scrollRoot.scrollTo({ top: target });
}

function computeProgress() {
  const scrollable = scrollableHeight(_scrollRoot);
  const progress = _scrollRoot.scrollTop / scrollable;
  const clamped = Math.max(0, Math.min(progress, 1));
  return clamped;
}

function onScrollProgress() {
  const progress = computeProgress();
  ScrollProgress.postMessage(progress);
}

addEventListener("scroll", onScrollProgress);

function onScrollEnd() {
  const progress = computeProgress();
  ScrollEnd.postMessage(progress);
}

if ("onscrollend" in window) {
  addEventListener("scrollend", onScrollEnd);
} else {
  console.log("falling back to manual scroll end detection");

  let touchings = new Set();
  addEventListener('touchstart', e => {
    for (let touch of e.changedTouches)
      touchings.add(touch.identifier)
  }, { passive: true });
  addEventListener('touchend', e => {
    for (let touch of e.changedTouches)
      touchings.delete(touch.identifier)
  }, { passive: true });
  addEventListener('touchcancel', e => {
    for (let touch of e.changedTouches)
      touchings.delete(touch.identifier)
  }, { passive: true });

  let timeout = 0;
  let scrollListener = () => {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      if (touchings.size > 0) {
        setTimeout(scrollListener, 100);
      } else {
        onScrollEnd();
      }
    }, 100);
  };
  addEventListener('scroll', scrollListener);
}
