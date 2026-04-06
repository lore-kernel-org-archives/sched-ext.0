Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6C38C400;
	Mon,  6 Apr 2026 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498976; cv=none; b=GuRZOSDMPeEC/EoxK8cdqYOb14cUb/xogCHY7I9YXymvZBdHuA2OvX7CtS6hpsBbRbQ0YvM3O+kcluqohuE4stn402yHa36O9mBAZU4/musTkhz8qBEPvPWlZXJYZzW82OIZpPQ9s6/DbaHnSmfizsKPS4jDS1l6AjO8yh8OB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498976; c=relaxed/simple;
	bh=UDnwZJHQS2QMxN3WIwlylMnWXvtxKxO9pw2dqdi5K4M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BOhTBJ/iNCUgAGev6CJX9BTxxQTGuU8qqig6+fIVw3FsORZFUw/0oJRqObKma0yVljg1Ip96mlVlOn1SzTDo0skD1TLBj15V46TID/0tlLUIMhGOyr03LPH1EOBHqMDEtVAi5R3zzL1h7o/pOAzGUnlvcPQwMDVpsZGw3gF8geg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7XHRhLO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7XHRhLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4EC4CEF7;
	Mon,  6 Apr 2026 18:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775498975;
	bh=UDnwZJHQS2QMxN3WIwlylMnWXvtxKxO9pw2dqdi5K4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7XHRhLO3XfwClP54f6KWsWwM/Ua9mhxiH2WNIM9hngwkcd9CeJBxMMb1uOOX8+po
	 9/Ls3X9zfyM89C/fEtfU6SY3d4eb1wzxJQZxWBajqotet51iFY7b5QvcFgY9RuBFkq
	 HeJqc9UYd6O25pJPIyrqojqh5IhB2EVCSJQgZYwv4BvCRUw6T7MwazjRSFscusoQrf
	 bJozwpXQQddAEk92+fuOFz+jEhlDWBGLXu6DPQ4J7MExGGk8ib9p4/wSp7bAp+s6Aw
	 F+7rIFD5e+2mJKJTnuUnzpot1IwlhwLreZc1iMKTkYjzMyogO5s5S8B8AOq0zWYZl/
	 BD238GFN5gG7Q==
Date: Mon, 06 Apr 2026 08:09:34 -1000
Message-ID: <ae0468705ed9b7c05b5b7728b5169aa8@kernel.org>
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
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload
 zeroing
In-Reply-To: <20260331091901.219894-1-yphbchou0911@gmail.com>
References: <20260331091901.219894-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> tools/sched_ext: Fix off-by-one in scx_sdt payload zeroing

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
