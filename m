Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6173B38BD;
	Fri, 10 Apr 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812322; cv=none; b=SLJon+elrrM/j/8qOd8RLsamQyjdTJZD9ESQlRzQWp6F8q0V/CYqHERJqEAPiHNFVgs7h18ENMAi6Ro6fiV1stldU5578aD4cz7Gyflr+hboCfzlyqVoKvu+jigWosHOahbheuw5sU/TSqKHHZUZqPk5Bz9SuJZLnZ5UT5dr1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812322; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T4DuU0E2eUg9kNr/EGoicD5Jd4oXoAdxj5bjf012VTmHfXvjSRADuXnRClZj0IPCUCodUWCR5oPfMmb2nCX2lo9wWDpD5CNWb17zO61NRPs0XtovXK7d0AsZuvu6M9aSyyW5kycaq3C15C2Yi5EeCfpllEPLIp0lvsXCPsUVcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqQUV4Fe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqQUV4Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06C4C19421;
	Fri, 10 Apr 2026 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775812321;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqQUV4Fe9rxPUqCuBJcWoWdJ+EfUZTeI9+cEvabY/og8nxPXVegC4iOUGoe/BXtQP
	 p8n9fkxn38FO3NThQgNPopHI+pwnWMLXXp0AQGk+nQvHj6L8gBnEmnY8/weHP6pcm1
	 jh+L2vu7WX+dZtlOyFQj5G8+Ps3t0gThm+hkqkPzrfvri8lwCUZcwwE647Q7eb8TgQ
	 str74Aw+HScyh1MXwU24ZesUbExztWhEls95zGrasVRpPjcm6aoD7VWlYalIa1m1Rk
	 T867sttiJ91iOCaoYJQ2piDik42hq+ypfioLlyPenvJK3qUwWNLCRDciqidsodl3Sf
	 6eYlNdYjtjFfA==
Date: Thu, 09 Apr 2026 23:12:00 -1000
Message-ID: <f5e679526b18d284d23339c5b74aa35b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: fangqiurong@kylinos.cn
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 shuah@kernel.org, christian.loehle@arm.com, newton@meta.com,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, emil@etsalapatis.com
Subject: Re: [PATCH] selftests/sched_ext: Fix wrong DSQ ID in peek_dsq
 error message
In-Reply-To: <20260410064753.469802-1-fangqiurong@kylinos.cn>
References: <20260410064753.469802-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
