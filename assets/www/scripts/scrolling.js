function scrollableHeight(element) {
  return element.scrollHeight - element.clientHeight;
}

function updateScrollProgress() {
  const content = document.body;
  const progress = content.scrollTop / scrollableHeight(content);
  const clamped = Math.max(0, Math.min(progress, 1));
  ScrollProgress.postMessage(clamped);
}

addEventListener("scroll", updateScrollProgress);

function scrollToProgress(progress) {
  const content = document.body;
  const target = progress * scrollableHeight(content);
  content.scrollTo({ top: target });
}
