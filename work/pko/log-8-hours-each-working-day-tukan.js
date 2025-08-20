workingDays = Array.from(document.querySelectorAll('td.day')).filter((el) => el.classList.length === 1);

workingDays.forEach((workingDay) => {
  const input = workingDay.querySelector('input');
  input.value = 8;
});

saveButton = document.querySelector('button[type="submit"][name="type"][value="save"].btn.button-default');

saveButton.click();
