Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570C337BB3;
	Fri,  6 Mar 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837288; cv=none; b=cn6QywN2EKHk++fBLv0Nw65lySdY6o7lRyljgglZ7leEpNaPxl/eynKoooe97ZZ5ZT9loyvoM5DJOfhuKSwXDqM4sWu5rJaG0Tp8tmRte/ltiRLdzv1wOZqSUlDhh10cMTfylERh214lGsjuc7m80s+okWg8PS9RDGoyQ7ucbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837288; c=relaxed/simple;
	bh=R6rVjDg0opnbmB8zy+M6ymLJEQb1dLZAF+3PJJxPwUc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RNpjVdzhxrVKLnNLIEe80cK8ALkACBW2eCqNJGDgzZwWQwUMrvgZqK9/R7oV8CqsNuPVh9YgWNSD2yj953953C3UYD6mwVto5nZPN7OM+7CM98nSn77t7AkCw9N8sVbdFwyHDlq3Np4XSlCOmCzqIDRZFadODCurfuO2grkUwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak25/PO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak25/PO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB1C4CEF7;
	Fri,  6 Mar 2026 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772837287;
	bh=R6rVjDg0opnbmB8zy+M6ymLJEQb1dLZAF+3PJJxPwUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ak25/PO2iT+BflGUehJ5Q5Nk2N3377oytYkqAudehUWFF8OkjehVOnY86Ix9QDMln
	 vCnskIL6B8qQRByabnpFH+z0XXodLzkGCbrTjhm9Z5e5sFJZyZLff5EsFOdb0uw5dt
	 mRidAxd12IFLiHG5/zG/4eZO5eycEsH4ip/w/Pnh+Qw9g6HhQfPGu5w2tkLliSRCTl
	 mVr3ssGLPY6HfKk6hn6E1qvQ/VWEVVPoIp9Ym5mW8n7pW7MZxHi5h5Q8F9N1Wc1zBd
	 nuc2pFw/rGnKj5LAyt8xWWVvUpp6awsvR/43LCobV/Da0uCF+UVogvhqaGraFso7kp
	 J80vSFs8QznfQ==
Date: Fri, 06 Mar 2026 12:48:06 -1000
Message-ID: <2a554e7cb73bd6b0b7400c7e747e7557@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 emil@etsalapatis.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Documentation: Update sched-ext.rst
In-Reply-To: <20260306182101.3085628-1-yphbchou0911@gmail.com>
References: <20260306182101.3085628-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with the following change.

Thanks.

--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
-  * ``scx_cpu0.[bpf].c``: A scheduler that queues all tasks to a shared DSQ
+  * ``scx_cpu0[.bpf].c``: A scheduler that queues all tasks to a shared DSQ

--
tejun
