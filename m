Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065333A719
	for <sched-ext@lists.linux.dev>; Mon, 23 Feb 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869422; cv=none; b=uqyXWJUPN0KC77WpQgltuU3+KpFu47qScG4FlwhFuxqlLmZlm9yHmSll3tC5CSX6C4exTk1xranK9Qb14Lir6ioojaYcGm7BjVGSVD72vlOyPRPYXknUu77TiyPj7/azIv3sOUwX8H39QqCTnzhQ8VbUHOM5XAlk0h1pEpkLVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869422; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOhOcKaK7xrAFKlTvolfr5Wl+PP6LXKC7BkyUP+r/p18cs10nVN1Tx4+lOVUqBoKxabYkTERMvKFgmUDyL4O02HoHefCn0+iyPR0yxkpuUBJeY1KgpfSM6gpMyIogMPrbWZWr1+6htsLWdRRZ+NXloL7x8GDFodRubMh41V/x+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITxFRsGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITxFRsGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDFFC116C6;
	Mon, 23 Feb 2026 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869421;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITxFRsGzGwHq4u68rD+5TMd/mlOYEy6ecGI0aWO1PEdn790sX3jxJbxEsSECqbJbH
	 x11dX8Xdvah6elgTIZNLAJFcJlrW1DGxwQreG0gMsXerKf4+3NMFigYvjZiSfdEN8m
	 HS4C6Dagw63wVZGKY7yIsEJZ0UYbtDRVIp3y37JPfdv07yyjRHEk46PK7jEJRktzIT
	 +dqyzbvqJyRLfxTFY43W/Jizjj5oz6/Ailj9NPNlJ8QJBowxaKmRwqxktOp9zOtjLh
	 du0Nl3QmVs8AU6DFM6jFlgWLGMdJyvQBEl79P2REuZ6lMiLJRJ/f6uFGhLfxLRiIKB
	 BZltxvAY83zAQ==
Date: Mon, 23 Feb 2026 07:57:00 -1000
Message-ID: <5f4c4575da164fe598c37b8d58af5d46@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] selftests/sched_ext: Abort test loop on signal
In-Reply-To: <20260221154042.1171011-1-yphbchou0911@gmail.com>
References: <20260221154042.1171011-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
