<%@ Page Language="C#"%>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result</title>
    <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

  <script src="https://code.jquery.com/jquery-1.12.1.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
    <div class="container">
<%
    // Initialize arrays
    dynamic competitors = JsonConvert.DeserializeObject(Request.Form["competitorList"]);

    List<dynamic> sortedCountries = new List<object>();
    List<dynamic> worldRecordList = new List<object>();

    // World Record Array
    foreach (var competitor in competitors)
    {
        if (competitor.worldRecord == "Yes")
        {
            worldRecordList.Add(competitor);
        }
    }

    int checkGold(string medal)
    {
        int count = 0;
        if (medal == "Gold")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int checkSilver(string medal)
    {
        int count = 0;
        if (medal == "Silver")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int checkBronze(string medal)
    {
        int count = 0;
        if (medal == "Bronze")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int countMedals(int gold, int silver, int bronze)
    {
        int count = 0;
        count = count + gold + silver + bronze;
        return count;
    }

    /** For Printing each sorted countries
    for (var i =0; i < sortedCountries.Count; i += 1)
    { 
        Response.Write(sortedCountries[i]);
    }

    sortedCountries.Add
    ((
        country: competitor.Value<string>("country"),
        name: competitor.Value<string>("name")
    ));

    /*/

    // Initialize sortedCountries
    foreach(var competitor in competitors)
    {

        if (sortedCountries.Count == 0)
        {
            // 1. Add country if array is empty
            sortedCountries.Add(new  {
                country     = competitor["country"],
                gold        = checkGold(competitor["medal"]),
                silver      = checkSilver(competitor["medal"]),
                bronze      = checkBronze(competitor["medal"]),
                totalMedals = countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
            });
        }
        else
        {
            // Update existing country details
            var countryExists = sortedCountries.Find(x => x.country == competitor.country);
            var countryIndex  = sortedCountries.FindIndex(x => x.country == competitor.country);

            //Response.Write("Existing country index: " + countryExists);
            if (countryIndex != -1)
            {
                // 2. Override existing country values
                sortedCountries[countryIndex].Add(new {
                    country     = competitor["country"],
                    gold        = (checkGold(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["gold"])),
                    silver      = (checkSilver(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["silver"])),
                    bronze      = (checkBronze(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["bronze"])),
                    totalMedals = sortedCountries[countryIndex]["total-medals"] += countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                });
            }
            else
            {
                // 3. Add country if it does not exists yet
                sortedCountries.Add(new
                {
                    country     = competitor["country"],
                    gold        = checkGold(competitor["medal"]),
                    silver      = checkSilver(competitor["medal"]),
                    bronze      = checkBronze(competitor["medal"]),
                    totalMedals = countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                });
            }

        }
    }
    %>
    <!-- Competitors -->
		<div>
			<div class="wrap-table100">
                <br />
        <div class="back-button"><a href="index.php">Back</a></div><br>
        <h1>Competitors</h1><br>
				<div class="table100 ver1 m-b-110 table">
					<div class="table100-head">
						<table>
							<thead>
								<tr >
									<th class="cell100 column1">Country</th>
									<th class="cell100 column2">Gold</th>
									<th class="cell100 column3">Silver</th>
									<th class="cell100 column4">Bronze</th>
									<th class="cell100 column5">Total Medals</th>
									<th class="cell100 column6">Rank</th>
								</tr>
							</thead>
						</table>
					</div>
				
					<div class="table100-body js-pscroll">
						<table>
							<tbody>
							 <%
                                    foreach (var country in sortedCountries)
                                    {
                                    %>
                                        <tr>
                                            <td><% Response.Write(country.country); %></td>
                                            <td><% Response.Write(country.gold); %></td>
                                            <td><% Response.Write(country.silver); %></td>
                                            <td><% Response.Write(country.bronze); %></td>
                                            <td><% Response.Write(country.totalMedals); %></td>
                                        </tr>
                                    <%
                                    }
                                    %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

        	<!-- World Record -->
		<!-- Display world record table if row exists -->
		<div>
			<div class="wrap-table100">
        <h1>World Record</h1><br>
				<div class="table100 ver1 m-b-110">
					<div class="table100-head">
						<table>
							<thead>
								<tr class="row100 head">
									<th class="cell100 column1">Athletes</th>
									<th class="cell100 column2">Sports</th>
								</tr>
							</thead>
						</table>
					</div>
				
					<div class="table100-body js-pscroll">
						<table>
							<tbody>
							 <%
            foreach (var worldRecord in worldRecordList) 
            {
        %>
                <tr>
                    <td><% Response.Write(worldRecord.name); %></td>
                    <td><% Response.Write(worldRecord.@event); %></td>
                </tr>
        <%
            }
        %>
							</tbody>
						</table>

					</div>
				</div>
			</div>
		</div>

	<!-- End of container -->
    </div>
    <script src="js/script.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/select2/select2.min.js"></script>
    <script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script>
        $(".js-pscroll").each(function () {
            var ps = new PerfectScrollbar(this);

            $(window).on("resize", function () {
                ps.update();
            })
        });
    </script>
</body>
</html>

