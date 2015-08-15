d3.csv("http://proximityviz.com/abc-bike-counts/pneumatic/for-d3.csv", function(d) {
  return {
    hour: d.hour,
    WeekdayBeltline: +d.WeekdayBeltline,
    WeekendBeltline: +d.WeekendBeltline,
    WeekdayOther: +d.WeekdayOther,
    WeekendOther: +d.WeekendOther
  };
}, function(error, rows) {
  var hour = _.pluck(rows, 'hour');
  hour.unshift('Hour');
  var weekdayBeltline = _.pluck(rows, 'WeekdayBeltline');
  weekdayBeltline.unshift('Weekday Beltline');
  var weekendBeltline = _.pluck(rows, 'WeekendBeltline');
  weekendBeltline.unshift('Weekend Beltline');
  var weekdayOther = _.pluck(rows, 'WeekdayOther');
  weekdayOther.unshift('Weekday Other');
  var weekendOther = _.pluck(rows, 'WeekendOther');
  weekendOther.unshift('Weekend Other');
  console.log(weekendOther);
  // build viz here:
  var chart1 = c3.generate({
    bindto: '#weekday-beltline-chart',
    data: {
      x: 'Hour',
      x_format: '%H:%M',
      columns: [
        hour,
        weekdayBeltline
      ],
      type: 'bar'
    },
    legend: {
      show: false
    },
    axis: {
      y: {
        label: 'Riders per Hour'
      },
      x: {
        type: 'timeseries',
        tick: {
          format: '%I:%M %p'
        }
      }
    },
    bar: {
      width: {
        ratio: 0.8
      }
    }
  });

  var chart2 = c3.generate({
    bindto: '#weekend-beltline-chart',
    data: {
      x: 'Hour',
      x_format: '%H:%M',
      columns: [
        hour,
        weekendBeltline
      ],
      type: 'bar'
    },
    legend: {
      show: false
    },
    axis: {
      y: {
        label: 'Riders per Hour'
      },
      x: {
        type: 'timeseries',
        tick: {
          format: '%I:%M %p'
        }
      }
    },
    bar: {
      width: {
        ratio: 0.8
      }
    }
  });

  var chart3 = c3.generate({
    bindto: '#weekday-other-chart',
    data: {
      x: 'Hour',
      x_format: '%H:%M',
      columns: [
        hour,
        weekdayOther
      ],
      type: 'bar'
    },
    legend: {
      show: false
    },
    axis: {
      y: {
        label: 'Riders per Hour'
      },
      x: {
        type: 'timeseries',
        tick: {
          format: '%I:%M %p'
        }
      }
    },
    bar: {
      width: {
        ratio: 0.8
      }
    }
  });

  var chart4 = c3.generate({
    bindto: '#weekend-other-chart',
    data: {
      x: 'Hour',
      x_format: '%H:%M',
      columns: [
        hour,
        weekendOther
      ],
      type: 'bar'
    },
    legend: {
      show: false
    },
    axis: {
      y: {
        label: 'Riders per Hour'
      },
      x: {
        type: 'timeseries',
        tick: {
          format: '%I:%M %p'
        }
      }
    },
    bar: {
      width: {
        ratio: 0.8
      }
    }
  });

  // setTimeout(function () {
  //     chart1.axis.max(100);
  //     chart2.axis.max(100);
  //     chart3.axis.max(100);
  //     chart4.axis.max(100);
  // }, 5000);
});

