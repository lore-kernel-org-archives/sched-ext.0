Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9A190473;
	Tue, 15 Sep 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459342; cv=none; b=NeUnh8BOEHOqarfKNciHnTL5NkAH+YIBvG/yHuUZ+LHnDCcy+fnINCHYbLy2JIDZb0NK0owVO3Meto9+7dD8WINekN3FwVgXmIrBSz1xlEL3MT/NpNcmNnS6IkUJocR18RQMhaqevsXxkUjbz99o8UpJh6Q8x6fwfGANpjsgS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459342; c=relaxed/simple;
	bh=XPCV2EXwKWQyfrvA1QZTuvPMbFthaCSpS33HqZkjmGo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Y99sN06igsONf9g1C34gZIzlSoshxuReKH18kmwO/p+ovkfblw72FRV0smOApvs/HP7bNC++fY4OjDUMtzhZgy8AQRSLqcq1riY7NHmtNnBX45ERqcy3IqXOCCDVIyZCB5XuKIjnZr6G5n2MSxbNBOr237p2mNeSjP9sHoIaKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za1HnG43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za1HnG43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1A21F000FF;
	Tue, 15 Sep 2026 08:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789459341;
	bh=XPCV2EXwKWQyfrvA1QZTuvPMbFthaCSpS33HqZkjmGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Za1HnG430P/igkseay6f4xXtLHaSx6ssUg3mZXNCdfnDBcRMQ7gvtcB5/j4cwwpOY
	 FnzdKX0tmkd0Qt4edbQ98PUJlAcYBOw2B4h3M/i4uFBiZGCHUowBHHPqTg4sRqhdeM
	 fch9hqPmFpXmjUUXa7DFTXv0XBmpVBLZiF4YYTdIzuxjUObaJqVCGCs8xMWE7vbac9
	 f/jukLc8BQ+FDxLI0bJ1Szh0a9v0xrVqru3+0Y6KEBFjTAExXkis8tSb+UTHWWFw7w
	 /gxOR+JeuNhigdWLe9QDh8IS+lh3CiyIWueRy2cMYtpk6nCI6jcLye7mAnghmOCsdN
	 CKshHNLpp0t3Q==
Date: Mon, 14 Sep 2026 22:02:20 -1000
Message-ID: <58dade5e9db51c3e4a4110da023704dc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix idle state tracking across idle
 repicks
In-Reply-To: <aqjkdw_Ds_O8W4eR@gpd4>
References: <20260914234259.3585373-1-tj@kernel.org>
 <20260914234259.3585373-2-tj@kernel.org>
 <aqjkdw_Ds_O8W4eR@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Sep 15, 2026 at 08:23:51AM +0200, Andrea Righi wrote:
> We discussed essentially the same behavior here:
> https://lore.kernel.org/r/Zw5_FlXfbLXDLCPG@slm.duckdns.org
...
> The unused-reservation case can already be handled by restoring the cid's idle
> state at the end of ops.dispatch() when no task was selected for dispatch. For
> example, scx_cidland does this:
> https://github.com/sched-ext/scx/blob/6c54f4f664bb8e9cc445c8333128b4ba17b93608/scheds/experimental/scx_cidland/src/bpf/main.bpf.c#L2960

I completely forgot about that discussion. You're right, restoring the
claim from ops.dispatch() is the way to go. Dropping this patch. I'll
update scx_qmap to do that and document the pattern in ops.update_idle()
instead.

Thanks.

--
tejun
