Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E74A3E;
	Sat, 13 Dec 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765588717; cv=none; b=HSIhHJ6P4zT8KLbMLel3Qz5WJK96AzY4++X6prvjfBO3O8RsOfRM57XoJ2WGiFFkdnpUepa251+S303U06rxWkxduLLa4X+7fjWormC9m/ONEjs0it16abieWF/veaZNKpXzbJx3j2SZflEd+cHmuk8JScBR2VOaq6RimnDUPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765588717; c=relaxed/simple;
	bh=BKlkcmxq7dkXDkz3WflMv5C1w5rEmRBk4a7qOMeIf+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t39iXFs8BFHJ0SodnC3bVF0BeE6KTuL5CIzTjd8CyUeGqRgp4oA4j2ieY+9OfsbuCUf7/SBFOpMvi3292mIirmN6u8Nn6lGSUorVQQAFVo1hFf9A2oJmGOtIHFtsLuL/02irmsDEHtLI+PNmJa4T9E6eulmP5ELtVpaIaWRrqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxDFxXob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxDFxXob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C5C4CEF1;
	Sat, 13 Dec 2025 01:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765588717;
	bh=BKlkcmxq7dkXDkz3WflMv5C1w5rEmRBk4a7qOMeIf+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxDFxXobNsTGBU0vd/qvoQ8vf3IolMH+Ez8Nm2t4dpMa70cGineCOlD72yRZ5S2h2
	 t0K7zlrxJSd/ItWOfj7z/fgS67aHfr1o3d2bEqDHFTu60r0s8+AKY6ePWlaN3t/EmY
	 2Am0JQr6pC9FCRkSus/fE2c9/jm98byo3hYbMXJbbDs6tHFGv+uBfO5r1oCEjKUdfv
	 OFcD9GGHeGF/wWliIhckVKBiGZDKPW+x4KaKpT3zEmh/7rx0r6DFeNvixlR2R59O1T
	 VE1zwsN2gPG/QfYvmL6JbaPYV41v3c8WrMXtlmGwzZ8mYuN/txzKKjl9qc/SdWpsXL
	 08kInXEVJqadw==
Date: Fri, 12 Dec 2025 15:18:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aTy-69iu1wiqmW4y@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
 <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>
 <aTruf0rK94ujYH0f@slm.duckdns.org>
 <aTrvRpr8yblKXlP7@slm.duckdns.org>
 <aTy-fFNjiVfMZ-cP@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTy-fFNjiVfMZ-cP@gpd4>

On Sat, Dec 13, 2025 at 02:16:44AM +0100, Andrea Righi wrote:
> > That doesn't fix the ordering problem in the other direction, but the
> > reordering in the other direction seems inherently less useful at least.
> > Maybe this can also be solved with seq - ie. make enqueue record the current
> > seq, mark the DSQ with the latest reenqueue seq and at enqueue commit time
> > if the captured seq is alreaddy reenqueued, trigger reenqueue.
> 
> How about making it even more explicit renaming the kfunc to something like
> scx_bpf_async_reenqueue_local() (and documenting it)?

I don't know. It's an implementation detail that can change in the future
and we don't want to be adding _async to e.g. scx_bpf_dsq_insert() too.

Thanks.

-- 
tejun
