const Pool = require('pg').Pool
const pool = new Pool({
    user: 'me',
    host: 'localhost',
    database: 'tabmanager',
    password: '2b6c',
    port: 1500,
});

const getLinks = (request, response) => {
    pool.query('SELECT * FROM links', (error, results) => {
        if (error) {
            throw error;
        }
        response.status(200).json(results.rows);
    });
};

const getLinkById = (request, response) => {
    const id = parseInt(request.params.id);

    pool.query('SELECT * FROM links WHERE ID = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        response.status(200).json(results.rows);
    });
};

const createLink = (request, response) => {
    const { title, category, link } = request.body;

    pool.query('INSERT INTO links (title, category, link) VALUES ($1, $2, $3) RETURNING *', [title, category, link], (error, results) => {
        if (error) {
            throw error;
        }
        response.status(201).send(`Link added with ID: ${results.rows[0].id}`);
    });
};

const updateLink = (request, response) => {
    const id = parseInt(request.params.id);
    const { title, category, link } = request.body;

    pool.query(
        'UPDATE links SET title = $1, category = $2, link = $3 WHERE ID = $4',
        [title, category, link, id],
        (error, results) => {
            if (error) {
                throw error;
            }
            response.status(200).send(`Link modified with ID: ${id}`);
        });
};

const deleteLink = (request, response) => {
    const id = parseInt(request.params.id)

    pool.query('DELETE FROM links WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        response.status(200).send(`links deleted with ID: ${id}`);
    });
};

const searchLinks = (request, response) => {
    const query = parseInt(request.params.id);

    pool.query('SELECT * FROM links WHERE title % $1', [query], (error, results) => {
        if (error) {
            throw error;
        }
        response.status(200).json(results.rows);
    });
};

module.exports = {
    getLinks,
    getLinkById,
    createLink,
    updateLink,
    deleteLink,
    searchLinks,
    pool,
};