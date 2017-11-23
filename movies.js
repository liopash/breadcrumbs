const movieList = [
  {
    title: "Batman",
    year: 1989,
    director: "Tim Burton",
    imdbRating: 7.6
  },
  {
    title: "Batman Returns",
    year: 1992,
    director: "Tim Burton",
    imdbRating: 7.0
  },
  {
    title: "Batman Forever",
    year: 1995,
    director: "Joel Schumacher",
    imdbRating: 5.4
  },
  {
    title: "Batman & Robin",
    year: 1997,
    director: "Joel Schumacher",
    imdbRating: 3.7
  },
  {
    title: "Batman Begins",
    year: 2005,
    director: "Christopher Nolan",
    imdbRating: 8.3
  },
  {
    title: "The Dark Knight",
    year: 2008,
    director: "Christopher Nolan",
    imdbRating: 9.0
  },
  {
    title: "The Dark Knight Rises",
    year: 2012,
    director: "Christopher Nolan",
    imdbRating: 8.5
  }
];

const titles = () => {
  const titles = [];
  for (const movie of movieList) {
    titles.push(movie.title);
  }
  return titles;
};

const nolanMovies = () => {
  for (const movie of movieList) {
    if (movie.director === "Christopher Nolan") {
      nolanMovieList.push(movie);
    }
  }
};

//const nolanMovieList = [];
//console.log(nolanMovies(), nolanMovieList);

const before2000 =  movieList.filter(x => x.year < 2000).map(x => x.title);
       

//console.log(before2000)

const hovadina = {
    jedna: 'one',
    dva: 'two',
    tri: 'three'
}
//

const arrays = [[1, 4], [11], [3, 5, 7]];

const sumz = arrays.map(x => x.reduce((x,y) => x + y)).reduce((x,y) => x + y)

console.log(sumz)

//console.log(Object.values(hovadina))