async function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

exports.pc_searching = async (req, res, next) => {
    await sleep(5000);
    
    res.status(200).json({ connected: true });
};