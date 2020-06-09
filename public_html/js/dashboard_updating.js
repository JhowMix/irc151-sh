setInterval( () => {
    fetch(
      '../shell/checagem.sh',
      {
        method: 'get',
      }
    )
    .then( response => {
      return response.json()
    })
    .then( result => {
      if(result.pc1_status === 0) {
        pc_1 = document.getElementsByClassName('pc')[0]
        pc_1.style.backgroundColor = "#0dff00"
      } else {
        pc_1 = document.getElementsByClassName('pc')[0]
        pc_1.style.backgroundColor = "#fc0303"
      }
    })
  },
  1000)


