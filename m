Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0439449ED6
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292614; cv=none; b=BLDaXbaAi3Vr8FKHCkxBfgO4m1aajA6oZrfA1UFJiWsuFTwu9Sv+yundo8PPusGd8BJ4WBQVps5ty6I7VgIgTg79bxG7BksDoDwDn/CGR8USrFNxbjSKEZ9+FHHSX9PhUmEXS0k1ATKJ6suCsCLr8+VYxwO+n2v2Xhvv2tVV/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292614; c=relaxed/simple;
	bh=mqfuJuzZYSOYABuEX5OYlzna8jxl08EBJ9Jfn8cJCy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvk17+UZC4COG/iqnY39PEEo5Zik1C3pleRkQdcLCspy8I4z+PQ1ZfJiD/Tpfi4UtyShj6l7ovuUig5En11f17DjqH0aPAc67Y9cMHGZrJPJkUaErejU4yn2x5qNBf9j7We5btkfV1PU2H7bvz6S4J8dHX27UzHzl1aDj97lsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIPRcYII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIPRcYII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473C81F000E9;
	Tue,  1 Sep 2026 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788292612;
	bh=XeIq9I0WlX8OQswYD4LDe15seXZKe5xXrNcYvsPdDqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VIPRcYIIkG3n/jMmt2hs4pomAwTbOR/fGssukmHMiOh2mKqoCwk09RgFhIxwuFxwm
	 hImKjM1OrZ6ePhIuDbtzERR8KKoFspAtsgMVBtsFE3SuacDF77DKK7DRSUymSzwrCx
	 Kudmqzy9feiMm6R19kSEENRozqxtGcGPGQoX2gepIh3gTF5rTD8fiYL2dfd/aTr+h+
	 7VOfSA4bXUhEt0YStYzvI1Xf494Bh3FSJ4LPgX3NWOVco2t8NgpF5h5iBJeEpUcHAk
	 6bL7X6gm3UYYFPav7/znoKtS42KNvWGxjteLlxrY8mRQOKTHFF3Bc8YdZ+mRvOatvf
	 3YUrkr0Pu7GBg==
Date: Tue, 1 Sep 2026 09:56:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Delete sub-scheduler kobjects before
 releasing scx_enable_mutex
Message-ID: <apcuA5kzwRCu_P-V@slm.duckdns.org>
References: <20260901102240.2671888-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901102240.2671888-1-fangqiurong@kylinos.cn>

On Tue, Sep 01, 2026 at 06:22:40PM +0800, Qiurong Fang wrote:
> From: fangqiurong <fangqiurong@kylinos.cn>
> 
> The sub-scheduler disable path deletes the scheduler's kobjects after
> releasing scx_enable_mutex, while the root path deletes them before
> releasing it. A concurrent enable on the same cgroup can therefore hit
> kobject_add() with the same "sub-%llu" name still in the hierarchy and
> fail with -EEXIST, tearing down an otherwise healthy scheduler.
> 
> Move the two kobject_del() calls above mutex_unlock() to match the root
> path.

Why is this a problem? The subsched hasn't been fully unloaded yet so if you
try to attach a new one, it's going to fail.

Thanks.

-- 
tejun
