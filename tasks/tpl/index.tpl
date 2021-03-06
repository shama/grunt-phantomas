<%
  var allMetrics      = _.keys( results[ 0 ] );
  var numericMetrics  = _.reduce( allMetrics, function( old, current ) {
    if ( typeof results[ 0 ][ current ].median === 'number' ) {
      old.push( current );
    }

    return old;
  }, [] );
  var groupedMetrics  = [];
  var counter         = 0;
  var columnsPerTable = 7;
  _.each( allMetrics, function( metric, index ) {
    if ( index !== 0 && index % columnsPerTable === 0 ) {
      ++counter;
    }

    if ( groupedMetrics[ counter ] === undefined ) {
      groupedMetrics[ counter ] = [];
    }

    groupedMetrics[ counter ].push( metric );
  } );
%>


<!DOCTYPE html>
<html>
  <head>
    <title></title>
    <link rel="stylesheet" href="public/styles/phantomas.css" media="all">
  </head>
  <body>
    <header class="p--header">
      <span class="p--header--span">Frontend stats for <a href="<%= url %>" data-url="<%= url %>" target="_blank"><%= url %></a></span>
      <select id="p--switcher" class="p--switcher">
        <option value="average">Average</option>
        <option value="min">Min</option>
        <option value="median" selected="selected">Median</option>
        <option value="max">Max</option>
      </select>
    </header>
    <main>
      <h1>Stats for <%= url %></h1>
      <h2>Graphs of joy</h2>
      <ul id="p--graphs" class="p--graphs">
        <% _.each( numericMetrics, function( metric ) { %>
          <li id="graph--<%= metric %>" class="p--graphs--graph">
            <h3><%= metric %></h3>
            <svg></svg>
        <% } );%>
      </ul>
      <h2>Tables of wisdom ( median values )</h2>
      <% _.each( groupedMetrics, function( metrics ) { %>
        <table class="p--table">
          <thead class="p--table--head">
            <th class="p--table--column">Date</th>
            <% _.each( metrics, function( key ) { %>
              <th class="p--table--column"><%= key %></th>
            <% } ); %>
          </thead>
          <tbody class="p--table--body">
            <% _.each( results, function( result ) { %>
              <tr class="p--table--row">
                <td class="p--table--column__highlight"><%= ( new Date( result.timestamp ) ).toISOString() %></td>
                <% _.each( metrics, function( metric ) { %>
                  <td class="p--table--column"><%= ( result[ metric ].median !== undefined ) ? result[ metric ].median : result[ metric ] %></td>
                <% } ); %>
              </tr>
            <% } ) %>
          </tbody>
        </table>
      <% } ); %>
    </main>
    <footer class="p--footer">
      Made with &#x2764; and <a href="https://github.com/macbre/phantomas" target="_blank">Phantomas</a>
    </footer>
    <script>var results = <%= JSON.stringify( results ) %></script>
    <script src="public/scripts/d3.min.js"></script>
    <script src="public/scripts/phantomas.min.js"></script>
  </body>
</html>
