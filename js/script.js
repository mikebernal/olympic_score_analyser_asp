/**
 * PUT SCRIPTS HERE THAT NEEDS TO RUN BEFORE DOMContentLoaded event.
 */

/**
 * Import jQuery
 */
(function ($) {
	"use strict";
	$('.column100').on('mouseover',function(){
		var table1 = $(this).parent().parent().parent();
		var table2 = $(this).parent().parent();
		var verTable = $(table1).data('vertable')+"";
		var column = $(this).data('column') + ""; 

		$(table2).find("."+column).addClass('hov-column-'+ verTable);
		$(table1).find(".row100.head ."+column).addClass('hov-column-head-'+ verTable);
	});

	$('.column100').on('mouseout',function(){
		var table1 = $(this).parent().parent().parent();
		var table2 = $(this).parent().parent();
		var verTable = $(table1).data('vertable')+"";
		var column = $(this).data('column') + ""; 

		$(table2).find("."+column).removeClass('hov-column-'+ verTable);
		$(table1).find(".row100.head ."+column).removeClass('hov-column-head-'+ verTable);
	});

})(jQuery);

/**
 * GET COUNTRIES
 * Invoked after DOMContentLoaded event.
 * Fetch list of countries from assets/countries.json. 
 * 
 */
(async function () {
  const countries = 'assets/countries.json'; 
  await fetch(countries)
    .then(function(response) { return response.json(); })
    .then(function (contents) {
      return Object.entries(contents).forEach(
        country => {
          var option       = document.createElement('OPTION');
          option.innerHTML = country[1].name;
          option.value     = country[1].name;
          document.querySelector('.country').appendChild(option);
        }
      );
    })
    .catch(function() { return console.log('Can’t access ' + countries + ' response. Blocked by browser?') })
})();

/**
 * GET EVENTS
 * Invoked after DOMContentLoaded event.
 * Fetch list of events from assets/events.json. 
 * 
 */
(async function () {
  const events = 'assets/events.json'; 
  await fetch(events)
    .then(function (response) { return response.json(); })
    .then(function (contents) {
      return Object.entries(contents).forEach(
        event => {
          var option       = document.createElement('OPTION');
          option.innerHTML = event[1].name;
          option.value     = event[1].name;
          document.querySelector('.event').appendChild(option);
        }
      );
    })
    .catch(function() { return console.log('Can’t access ' + events + ' response. Blocked by browser?'); })
})();

/**
 * Initialize commence date date picker ui
 */
$(".commence-date").datepicker({
  onSelect: function(selected) {
    $(".end-date").datepicker("option","minDate", selected)
  }
});

/**
 * Initialize end date date picker ui
 */
$(".end-date").datepicker({ 
  onSelect: function(selected) {
    $(".commence-date").datepicker("option","maxDate", selected)
  }
});  

// Initialize Global Variables
var i = 0;
var competitors = [];

var year          = document.querySelector('.year');
var city          = document.querySelector('.city');
var commenceDate  = document.querySelector('.commence-date');
var endDate       = document.querySelector('.end-date');

var competitor  = document.querySelector('.competitor');
var country     = document.querySelector('.country');
var event       = document.querySelector('.event');
var medal       = document.querySelector('.medal');
var worldRecord = document.querySelector('.world-record');
var addBtn      = document.querySelector('.button__add');

// Disable Add button
function disableAddBtn() {
  addBtn.disabled = true;
  addBtn.classList.remove("btn-success");
  addBtn.classList.add("btn-light");
  addBtn.style.cursor = "default";
}

// Enable Add button
function enableAddBtn() {
  addBtn.disabled = false;
  addBtn.classList.remove("btn-light");
  addBtn.classList.add("btn-success");
  addBtn.style.cursor = "pointer";
}

// Check if input field is empty
function isEmpty(input) {
  input = input.trim();
  return (input.length === 0) ? true : false
}

// Check if year length <= 4 AND accepts only numbers
function validateYear(year) {
  const re = /^[0-9]{4,}$/;
  return re.test(year) ? true : false
}

// Check if competitor name is length <= 5 AND only letters
function validateCity(city) {
  const re = /^[A-Z a-z]/;
  return re.test(city) ? true : false
}

// Check if competitor name is length <= 5 AND only letters
function validateCompetitor(competitor) {
  const re = /^[A-Z a-z]{5,}$/;
  return re.test(competitor) ? true : false
}

/**
 * Enable Add button if competitor fields are not empty
 */ 
function checkVal() {
  if (
      (isEmpty(year.value) || !validateYear(year.value)) ||
      (isEmpty(city.value) || !validateCity(city.value)) ||
       isEmpty(commenceDate.value) ||
       isEmpty(endDate.value) ||
      (isEmpty(competitor.value) || !validateCompetitor(competitor.value)) ||
       isEmpty(country.value) ||
       isEmpty(event.value) ||
       isEmpty(medal.value) ||
       isEmpty(worldRecord.value)
  ) {
    disableAddBtn();
  } else {
    enableAddBtn();
  }

}

/**
 * Add competitor row into preview table
 */
function addRow() {
  
  addCompetitor(i);
  i += 1;
  disableAddBtn();
}

/**
 * DOM event listeners
 */
year.addEventListener('keyup',         checkVal);
city.addEventListener('keyup',         checkVal);
commenceDate.addEventListener('keyup', checkVal);
endDate.addEventListener('keyup',      checkVal);

competitor.addEventListener('keyup',   checkVal);
country.addEventListener('change',     checkVal);
event.addEventListener('change',       checkVal);
medal.addEventListener('change',       checkVal);
worldRecord.addEventListener('change', checkVal);
addBtn.addEventListener('click',       addRow);

/**
 * Update preview table
 */
function updateTable() {
  return ((competitors.length > 0)
            ? (
                document.querySelector('.competitors-div').style.display = 'flex',
                document.querySelector('.competitors-div').style.flexDirection = 'column'
              )
            : document.querySelector('.competitors-div').style.display = 'none'
  );
}

/**
 * Toggle Submit Button
 */
function renderSubmitBtn() {
  return ((competitors.length > 1)
            ? document.querySelector('.submit').style.display = 'block'
            : document.querySelector('.submit').style.display = 'none'
  );
}

/**
  * @param {int} index
  * Add Competitor details as rows in preview table.
  */
  function addCompetitor(index) {
  // Disabled add button if competitor data already exists in comeptitors table
  var newCompetitor = [];
  newCompetitor.push({
    'id':            index,
    'year':          document.forms[0].elements[0].value,
    'city':          document.forms[0].elements[1].value,
    'commence-date': document.forms[0].elements[2].value,
    'end-date':      document.forms[0].elements[3].value,

    'name':         document.forms[0].elements[4].value,
    'country':      document.forms[0].elements[5].value,
    'event':        document.forms[0].elements[6].value,
    'medal':        document.forms[0].elements[7].value,
    'world-record': document.forms[0].elements[8].value
  });

  // Check if incoming data already exists in preview table
  var alreadyExistsInArray = competitors.find(competitor => 
    competitor.year    === newCompetitor[0].year &&
    competitor.name    === newCompetitor[0].name &&
    competitor.country === newCompetitor[0].country &&
    competitor.event   === newCompetitor[0].event
  );

  if (alreadyExistsInArray) {
    // alert("Competitor data already exists in preview table!");
    // Reset competitor's input fields
    document.forms[0].elements[4].value = '';
    document.forms[0].elements[5].value = '';
    document.forms[0].elements[6].value = '';
    document.forms[0].elements[7].value = '';
    document.forms[0].elements[8].value = '';
    renderSubmitBtn();
  } else {
    // Create and append node to DOM
    var tr           = document.createElement('TR');
    var id           = document.createElement('TD');
    var name         = document.createElement('TD');
    var country      = document.createElement('TD');
    var event        = document.createElement('TD');
    var medal        = document.createElement('TD');
    var worldRecord  = document.createElement('TD');
    var edit         = document.createElement('TD');
    var remove       = document.createElement('TD');

    name.innerHTML        = document.forms[0].elements[4].value;
    country.innerHTML     = document.forms[0].elements[5].value;
    event.innerHTML       = document.forms[0].elements[6].value;
    medal.innerHTML       = document.forms[0].elements[7].value;
    worldRecord.innerHTML = document.forms[0].elements[8].value;
    id.innerHTML          = index;

    edit.innerHTML   = `<button type="button" class="btn btn-warning unselectable" onclick="editCompetitor(` + index + `)">edit</button>`;
    remove.innerHTML = `<button type="button" class="btn btn-danger pointer unselectable" onclick="removeCompetitor(` + index + `)">delete</button>`;

    var lastRow = document.querySelector('.competitors').lastChild;
    console.log(lastRow);
    lastRow.appendChild(tr);
    tr.appendChild(id);
    tr.appendChild(name);
    tr.appendChild(country);
    tr.appendChild(event);
    tr.appendChild(medal);
    tr.appendChild(worldRecord);
    tr.classList.add('row' + index);
    tr.appendChild(edit);
    tr.appendChild(remove);

    competitors.push({
      'id':           index,

      'year':          document.forms[0].elements[0].value,
      'city':          document.forms[0].elements[1].value,
      'commence-date': document.forms[0].elements[2].value,
      'end-date':      document.forms[0].elements[3].value,

      'name':         document.forms[0].elements[4].value,
      'country':      document.forms[0].elements[5].value,
      'event':        document.forms[0].elements[6].value,
      'medal':        document.forms[0].elements[7].value,
      'world-record': document.forms[0].elements[8].value
    });

    /**
     * Reset competitor's input fields
     */ 
    document.forms[0].elements[4].value = '';
    document.forms[0].elements[5].value = '';
    document.forms[0].elements[6].value = '';
    document.forms[0].elements[7].value = '';
    document.forms[0].elements[8].value = '';

    updateTable();
    renderSubmitBtn();
    payloadUpdate();
  }
 
}

// To do
function editCompetitor(index) {
  alert('Competitor\'s ID to edit: ' + index);
  // Update DOM here
}

/**
 *  Remove competitor on the preview table
 */
function removeCompetitor(index) {
  // splice element in competitors array
  competitors.forEach(function (competitor)  {
    (competitor.id === (index)) && competitors.splice(competitors.indexOf(competitor), 1)
  });

  // Update DOM here
  var rowToRemove = document.querySelector('.row' + index.toString());
  rowToRemove.remove();
  updateTable();
  renderSubmitBtn();
  payloadUpdate()
}

/**
 * Update Http request here
 * Converts obj to string for http consumption
 */
function payloadUpdate() {
  var payloadRequest = document.querySelector('.competitor-list');
  payloadRequest.value = JSON.stringify(competitors);
  console.log(payloadRequest.value);
}
