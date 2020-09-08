<?php
  /**
   * Initialize variables
   */
  $competitors     = json_decode($_SESSION["competitors"], true);
	$sortedCountries = array();
	$worldRecord     = array();

	/**
   * Initialize wordRecord array
   */
	foreach($competitors as $competitor) {
		if ($competitor['world-record'] === 'Yes') {
			array_push($worldRecord, [
				'athletes' => $competitor['name'],
				'event'    => $competitor['event']
			]);
		}
	}

  /**
   * checkGold function
   *
   * @param [string] $medal
   * @return 1 || 0
   */
	function checkGold($medal) {
		$count = 0;
		if ($medal === 'Gold') {
			$count = $count + 1;
			return $count;
		} else {
			return $count;
		}
	}

  /**
   * checkSilver function
   *
   * @param [string] $medal
   * @return 1 || 0
   */
	function checkSilver($medal) {
		$count = 0;
		if ($medal === 'Silver') {
			$count = $count + 1;
			return $count;
		} else {
			return $count;
		}
	}

  /**
   * checkBronze function
   *
   * @param [string] $medal
   * @return 1 || 0
   */
	function checkBronze($medal) {
		$count = 0;
		if ($medal === 'Bronze') {
			$count = $count + 1;
			return $count;
		} else {
			return $count;
		}
	}

  /**
   * countMedals function
   *
   * @param (int)[string] $gold
   * @param (int)[string] $silver
   * @param (int)[string] $bronze
   * @return summation of all medals
   */
	function countMedals($gold, $silver, $bronze) {
		$count = 0;
		$count = $count + $gold + $silver + $bronze;
		return $count;
  }

  /**
   * Initialize sortCountries array
   * 1. Add country if array is empty
   * 2. Override country values if country already exists
   * 3. Add country if it does not exists in array
   */
  foreach($competitors as $competitor) {

    if (empty($sortedCountries)) {
      // 1. Add country if array is empty
      array_push($sortedCountries, [
				'country'      => $competitor['country'],
				'gold'         => checkGold($competitor['medal']),
				'silver'       => checkSilver($competitor['medal']),
        'bronze'       => checkBronze($competitor['medal']),
        'total-medals' => countMedals(checkGold($competitor['medal']), checkSilver($competitor['medal']), checkBronze($competitor['medal']))
      ]);
    } else {
      $allCountries  = array_column($sortedCountries, 'country');
      $countryExists = in_array($competitor['country'], $allCountries);
      if ($countryExists) {
        // 2. Override existing country values
        $existingCountryIndex = array_search($competitor['country'], $allCountries);
        $sortedCountries[$existingCountryIndex] = array_merge($sortedCountries[$existingCountryIndex], [
          'country' => $competitor['country'],
          'gold'    => ( checkGold($competitor['medal']) + (int)$sortedCountries[$existingCountryIndex]['gold'] ),
          'silver'  => ( checkSilver($competitor['medal']) + (int)$sortedCountries[$existingCountryIndex]['silver'] ),
          'bronze'  => ( checkBronze($competitor['medal']) + (int)$sortedCountries[$existingCountryIndex]['bronze'] ),
          'total-medals' => $sortedCountries[$existingCountryIndex]['total-medals'] += countMedals(checkGold($competitor['medal']), checkSilver($competitor['medal']), checkBronze($competitor['medal']))

        ]);
        
      } else {
        // 3. Add country 
        array_push($sortedCountries, [
          'country' => $competitor['country'],
          'gold'    => checkGold($competitor['medal']),
          'silver'  => checkSilver($competitor['medal']),
          'bronze'  => checkBronze($competitor['medal']),
          'total-medals' => countMedals(checkGold($competitor['medal']), checkSilver($competitor['medal']), checkBronze($competitor['medal']))

        ]);
      }

    }
  }

  /**
   * sortByMedals
   * 
   * 1. Sort country tables based from num of medals
   *
   * @param [type] $x
   * @param [type] $y
   * @return void
   */
  function sortByMedals($x, $y) {
    // Rearrange countries based from their number of medals
    if($x['total-medals'] == $y['total-medals']) {
      return 0;
    }

    return $x['total-medals'] < $y['total-medals'];
  }

  /**
    * ================================================================================================
    * ================================================================================================
    * ====================================== Debugging purposes only =================================
    * ================================================================================================
    * ================================================================================================
    */
  
   /**
    * getRank function
    * Ref: https://php.developreference.com/article/21057501/Ranking+Position+on+value+of+array+in+PHP
    * 
    * @param [type] $x
    * @param [type] $y
    * @return void
    */
  function getRank($country) {
    global $sortedCountries;
    $ordered_values = $sortedCountries;
    rsort($ordered_values);
    foreach ($sortedCountries as $key => $value) {
      foreach ($ordered_values as $ordered_key => $ordered_value) {
        if ($value['total-medals'] > $ordered_value['total-medals']) {
          $key = $ordered_key;
          break;
        }
      }

      if ($country == $value['country']) {
        return ((int) $key + 1);
      }
  
      // echo $value['country'] . '- Rank: ' . ((int) $key + 1) . '<br/>';
      // 1. Pass country name
      // 2. return rank
    }
  }

  // echo "<pre>";print_r($sortedCountries);echo "</pre>";
?>
