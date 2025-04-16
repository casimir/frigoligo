function scrollableHeight(element) {
  return element.scrollHeight - element.clientHeight;
}


function scrollToProgress(progress) {
  const content = document.body;
  const target = progress * scrollableHeight(content);
  content.scrollTo({ top: target });
}

function computeProgress() {
  const content = document.body;
  const progress = content.scrollTop / scrollableHeight(content);
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
