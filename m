Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B1339B32
	for <sched-ext@lists.linux.dev>; Mon, 23 Feb 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869427; cv=none; b=rvyLR3U6+K7RoZuNoqy49Mas9h+cRmHSUo/8tTBJ9PM/NN/zdAljkKiRdQm1JjGx0+hk8SzgPCjCr3RGi4bEu4BFndYTDDFJY/qroLwkMolsWdvI25KO0MdC1tKqIi1H0wbjFEDprVO+DHbQm5EXSX/jYoLgGUGXjoudaBBULJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869427; c=relaxed/simple;
	bh=IMs7qzSi5yDBJrvyL2tKSAOwO1XEohrebVVSrRUzcDI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J40dJ51dUTYHmmvf+SNyMaV+hZOREGYebZVscz3G/p9cLW3JqfT/ttZ+Xxpb1U1SLxDTb2ordkzQ3mCHDU6iLYKd31DuDUmbHug/6ulExDr5lsOs158WLloAqKVouh2v/G0RAiBJTCClHhqtECiUsPU31V6vio+8F6qWNP7LJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0yQpV0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0yQpV0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123FC116C6;
	Mon, 23 Feb 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869426;
	bh=IMs7qzSi5yDBJrvyL2tKSAOwO1XEohrebVVSrRUzcDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0yQpV0Xq+byFR6Xwf9n7XR+ZZ+rpP/4OgBj7YjOZMsxA4hAOkYbRcViOULixH2s/
	 Dl0+axrLfm0DNqCNHlpErUCoX8GOWkRCUAr6tpTYuJfIa4RjxC//g1sX0jpFrFbfpz
	 cTPvJIEl7MNbGTO/3iMkp4ivt+ZM7JGkuU1yUcj35EkxcHUv5AnhfRzHA5vB8QtsRT
	 0jGabSWYEpEzllpoyPjLFrenLZeRAN4yfjlIx+68SB6GxYePYY+2a4BBIwx9o0hVvF
	 PZerchdunNQYW94NqPaFL4exRQZRTFuE8Mt5YGTuEkJHVuIDlgdkO52iBiKdQgXHj1
	 d8gRtNKSxBkyA==
Date: Mon, 23 Feb 2026 07:57:05 -1000
Message-ID: <0f42b77e47877563c765cc9bf4f9e9e6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/2] tools/sched_ext: Clean up unused getopt flags
In-Reply-To: <20260222130826.37085-1-yphbchou0911@gmail.com>
References: <20260222130826.37085-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

> Cheng-Yang Chou (2):
>   tools/sched_ext: scx_central: Remove unused '-p' option
>   tools/sched_ext: scx_sdt: Remove unused '-f' option

Applied 1-2 to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
