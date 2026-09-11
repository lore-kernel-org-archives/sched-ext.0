Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F25343893;
	Fri, 11 Sep 2026 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140288; cv=none; b=TybxbMv9bOfX34ZBuo0dkEOCJKkqw6l5QGMp259TkBaxBAWzGQw4cMr0w7TpKiqggZ8O6pIjYQ6znd73fdHCqU5/7/ICc6GvX93IPw/Olctkjw566ntxgYu/lGXKH1BPjY9RTvDWfntGiK/sW7/xr+smGBFZKaXJGhKaNwkbUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140288; c=relaxed/simple;
	bh=V2O6WzAnESLr2yQYCHfHE1ZXxxdBZXybjVOKTI8Lba0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IMJpm0YDZ5tFihJSNpHIHCRyJeChAZc083hZTK5MaWaR6n2/8Jayvzo+/zsHT7wh+RGrDshTP925rIuhZjnMLIn81Uvnh6Ft/96sIUgd3zrroCk0T4VfD+rbCQxlrs0+T0q6IftxPZ2t9qF6B8yr59SB9XVm6Ct3GX4qyDin4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNY20cTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNY20cTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B71F00898;
	Fri, 11 Sep 2026 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140286;
	bh=bZFG8hjbQ+crUPEETSshlmuaHxthzD4ir6qFk7vMToU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HNY20cTdtvcezDKmNDdYYOM5gfOse0+zpyanFKy9EDvycPV3TleOTXH8yqDMwDNN9
	 9m1FHkmK2uT+vnhNn/KNtFp5vsPeyRKfK8rxOPYvpqcEjK8IX4JGjoZeTfwxwJdzcl
	 33+T5cwQecsxggTw7DAwaVQVFbuu14B/e/8kH0gyoRtME0WqdTLkrzudXOHzZnwPrk
	 xkxWVtkE9gmOzF9F1a7vnZ+kiVS56KllgqytUxClcQqod3mN7Ry94iIti8KSeqavS5
	 idBweRrwHk4Nw1YEUiGBTniW4/wUw9SK4p1RILWqBamz6I3IJ2fjUQfJLiLntGA1jB
	 qaEE0w9SWOu5Q==
Date: Fri, 11 Sep 2026 05:24:45 -1000
Message-ID: <664afc289472acecc783762fdf7a9baa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org,
 tj@kernel.org
Subject: Re: [PATCH v2] sched_ext: Close the pre-enable ops error claim window
In-Reply-To: <20260911024256.125287-1-fangqiurong@kylinos.cn>
References: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
 <20260911024256.125287-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Fri, Sep 11, 2026 at 10:42:56AM +0800, Qiurong Fang wrote:
> +		scx_tryset_enable_state(SCX_DISABLED, SCX_ENABLING);

All allocation failures precede ops->priv publication, so no disable can
race here and the state must still be SCX_ENABLING. Please use:

        WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) != SCX_ENABLING);

Please also update the moved comment. Allocation failure still unwinds
locally. Full disabling on failure applies only after
scx_alloc_and_add_sched() succeeds.

Thanks.

-- 
tejun
