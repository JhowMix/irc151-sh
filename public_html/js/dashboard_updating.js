setInterval( () => {
    fetch('../shell/checagem.sh')
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

        if(result.pc2_status === 0) {
          pc_2 = document.getElementsByClassName('pc')[1]
          pc_2.style.backgroundColor = "#0dff00"
        } else {
          pc_2 = document.getElementsByClassName('pc')[1]
          pc_2.style.backgroundColor = "#fc0303"
        }

        if(result.pc3_status === 0) {
          pc_3 = document.getElementsByClassName('pc')[2]
          pc_3.style.backgroundColor = "#0dff00"
        } else {
          pc_3 = document.getElementsByClassName('pc')[2]
          pc_3.style.backgroundColor = "#fc0303"
        }

        if(result.pc4_status === 0) {
          pc_4 = document.getElementsByClassName('pc')[3]
          pc_4.style.backgroundColor = "#0dff00"
        } else {
          pc_4 = document.getElementsByClassName('pc')[3]
          pc_4.style.backgroundColor = "#fc0303"
        }

        if(result.pc5_status === 0) {
          pc_5 = document.getElementsByClassName('pc')[4]
          pc_5.style.backgroundColor = "#0dff00"
        } else {
          pc_5 = document.getElementsByClassName('pc')[4]
          pc_5.style.backgroundColor = "#fc0303"
        }

        if(result.pc6_status === 0) {
          pc_6 = document.getElementsByClassName('pc')[5]
          pc_6.style.backgroundColor = "#0dff00"
        } else {
          pc_6 = document.getElementsByClassName('pc')[5]
          pc_6.style.backgroundColor = "#fc0303"
        }
      })
  },
  1000)