Reveal.on('slidechanged', event => {
  const footer = document.querySelector('.slide-footer');
  const logo = document.querySelector('.slide-logo');

  const isTitle = event.currentSlide.classList.contains('title-slide');

  if (isTitle) {
    if (footer) footer.style.display = 'none';
    if (logo) logo.style.display = 'none';
  } else {
    if (footer) footer.style.display = '';
    if (logo) logo.style.display = '';
  }
});
