function checkMail() {
  return new Promise((resolve, reject) => {
    if (Math.random() > 0.5) {
      resolve('Mail has arrived');
    } else {
      reject(new Error('Failed to arrive'));
    }
  });
}

checkMail()
  .then((mail) => {
    console.log(mail);
  })
  .finally(() => {
    console.log('Experiment completed');
  })
  .finally(() => {
    console.log('Experiment completed2');
  })
  .catch((err) => {
    console.error(err);
  })
  .catch((err) => {
    console.error(err);
  });
