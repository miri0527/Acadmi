
$(document).ready(function() {
    $("#order").change(function() {
      let selectedValue = $(this).val();

    });
  
    // 동적으로 option 생성
    const urlParams = new URL(location.href).searchParams;
    const order = urlParams.get('order');
    let options = '<option value="">전체</option>'
    for(let i = 1; i <= 15; i++) {
      let selected = (order === i.toString()) ? 'selected' : '';
      options += `<option value="${i}" ${selected}>${i}주차</option>`;
    }
    $("#order").html(options);
  });