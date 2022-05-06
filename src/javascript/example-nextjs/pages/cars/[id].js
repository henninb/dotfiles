import {useRouter} from 'next/router'
import Head from 'next/head'

// export default function Car( {car} ) {
//   const router = useRouter();
//   const { id } = router.query

//   return (<>
//     <Head>
//       <title>my car</title>
//     </Head>
//     <h1>Hello {id}</h1>
//     car.year
//   </>)
// }

// export async function getStaticProps( {params} ) {
//   const req = await fetch(`http://localhost:3000/${params.id}.json`);
//   const data = await req.json();

//   return {
//     props: {car: data },
//   }
// }

// export async function getStaticPaths() {
//   const req = await fetch(`http://localhost:3000/cars.json`);
//   const data = await req.json();

//   const paths = data.map(car => {
//     return { parms: {id: car } }
//   })

//   return {
//     paths,
//     fallback: false
//   }
// }
//


export default function Car({car}) {

    const router = useRouter()
    const {id} = router.query
    return (
        <div>
            <Head>
                <title>{car.color} {car.id}</title>
            </Head>

            <main>
                <h1>
                    {id}
                </h1>
            </main>
        </div>
    )
}


export async function getServerSideProps({params}) {
    const req = await fetch(`http://localhost:3000/${params.id}.json`);
    const data = await req.json();

    return {
        props: {car: data},
    }
}
