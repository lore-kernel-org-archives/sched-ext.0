Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298333ADBF;
	Sun, 22 Mar 2026 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209312; cv=none; b=U8o0Dos735vKa1TyTvKAUo5hnPnSJ1n4qdbZCRGA2IE3uw3JzRq3g1g3Y6JTUjJ2b8ycbYRDqmFkHK7HL4xd+cuB13mc0U5qlc8gc3K/OqAkDJ+aNr7hD7AjqTZ0NZCC5CGIkHDDfVtKNukaBde/TUfQo0HarPSR4d/gEQKuYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209312; c=relaxed/simple;
	bh=oiuD5gPKofQwelfeyLjsbDwstiTz8Vz2m+tHMd/MpGI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jNmydbmozC33W2f9Sx5Lt0QtR3SsfHdsZkxTDZdFH44cXmfYZzdJEvI9g4Knd4KKSZ0H46ykljZkAsnS9jy7VwP9/hls+eCxkSwewjfNsoOxCe6Ju+m2uufxmDuV/elihbgrkO5ytPD1yYyz1rweKeAteBgdCy45C5fFOjWfnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb49iP6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb49iP6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240C5C19424;
	Sun, 22 Mar 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774209312;
	bh=oiuD5gPKofQwelfeyLjsbDwstiTz8Vz2m+tHMd/MpGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lb49iP6EacwSV9Fj6STJRdno/ZuQfZNdrbJwut/WfD/NAk2p+vwfdgfvziVP6WlXd
	 8UeXuiUIaEJtWQBqZqLuA8Ur5i8msDftDt0IfW7Ct2wiNfhRLAelV0tuadge43m/Hf
	 UW45Q/v4Uo5726zl7W/rc4ZCKOD4KBEuGVwk7N9eBYN12WzMpY8oupg8EWttHqCt2p
	 Ie29Tx2trZEbvTrfHbTWEeKcEhrbBps08hSw5xPXayWNVRhIl/6WZ7OW81IuGNHc7+
	 hmYqHNtRkw+WHqnZlnwydiLLrIfA1ITEf8ChzmXGt0fiqBb9xo8PspALFn2YlG5Hk+
	 GRlL/HyFygmZA==
Date: Sun, 22 Mar 2026 09:55:11 -1000
Message-ID: <c012fdc44ce9c0ea7c2b3bf291338f10@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix invalid kobj
 cast in scx_uevent()
In-Reply-To: <20260322171309.2640439-1-yphbchou0911@gmail.com>
References: <20260322171309.2640439-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The fix itself looks correct but could you please update a few things for v2?

- The patch description says that kset_register() of the sched_ext kset
  itself triggers this during init. That's not actually the case -
  kset_create_and_add() sets kobj.kset = NULL on the kset's own kobject,
  so kobject_uevent_env() can't find a kset and the uevent is silently
  dropped.

  The actual trigger is the sub-scheduler kset created at
  scx_alloc_and_add_sched() -> kset_create_and_add("sub", NULL,
  &sch->kobj). That sub-kset's kobject has sch->kobj as its parent, and
  sch->kobj.kset = scx_kset, so the uevent walk finds scx_kset and calls
  scx_uevent() with the sub-kset's kobject which isn't a struct scx_sched.

  Please update the description to reflect this.

- Move the variable declaration to the top of the function. There's no
  functional difference but the current placement looks messy - just put
  the ktype check between the declaration and the use.

- Add a comment explaining why the check is needed - that scx_uevent()
  can be reached by both scx_sched kobjects (scx_ktype) and sub-scheduler
  kset kobjects (kset_ktype) through the parent chain walk, and we need to
  filter out the latter.

Thanks.

--
tejun
