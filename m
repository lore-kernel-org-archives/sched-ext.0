Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107D189F43;
	Sun, 26 Jul 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785102498; cv=none; b=Yol3QuPlcjE1zBee9cgoRaiSNFTQdf6BSVs9jf70wsnAKbW5M/EukjqydPT+SPathGq1drJRxxDMgStUKd4SzwqYjnns/aMIF4xUtjhwIR+iyj+hrKUF8IsJEuaS1eFXC3rgs2yqKlut/27Ec3ZUuzZ2LIaSxP/NyWorgvbhV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785102498; c=relaxed/simple;
	bh=7ADCzGBP6pCk+07/1g0klprQwjFlrgluTuPFykDosJE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=lyWMeDkcTk72tE2xIczpJ+LeTtZKiqCABhJH3LsIHubApKuGFExpBgDqcOkTv1sq7j/apixLCcm/Fg34FgG6CZX0/qZJVcZD8e02TWjmCSU7vHyFPKtLtZt09eZA8mjdiTHttTTVUKRTHNw/gA36zf2t/LKXuK/jL7B1AfzJwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZRJbQVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZRJbQVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07A01F000E9;
	Sun, 26 Jul 2026 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785102497;
	bh=7ADCzGBP6pCk+07/1g0klprQwjFlrgluTuPFykDosJE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MZRJbQVtbDXvXBFmj6vofovzXylbD+7GkfLam4zlINjg4e5BlFA92zY3zTN41JZ5X
	 aThIg5EGgDTpKDTfEiL9yZB9RK/CYZcKNfz1KIa/YmY6KcmD2meJYuX6YiSkLqILp8
	 OcMKzGkkx3vwccx4B9/4VyA6Pyr3/ypDiprNZlZywhCqtr+8/nf6rSU1p48tquo/ap
	 aNgt5P9HPiAGXDJV2OSUBXqQhu78th9DTa0++ec8WY4V6JXQA26mBb+FTVUOOHnmGJ
	 wfJUDoX77Hex/5GjpFnxdLeMezT/Fzk8JK8pvtJ2UGbmClScziRp+3M+Cs9wiY9sdv
	 xsOWEvAwlXzOw==
Date: Sun, 26 Jul 2026 11:48:15 -1000
Message-ID: <a5c5169816ddb1c0d3b52c20058ae486@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
    Andrea Righi <arighi@nvidia.com>,
    Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
    Emil Tsalapatis <emil@etsalapatis.com>,
    linux-kernel@vger.kernel.org
In-Reply-To: <6649066b805d5660b598f3155c30daac@kernel.org>
References: <6649066b805d5660b598f3155c30daac@kernel.org>
Subject: Re: [PATCH v3 sched_ext/for-7.3] sched_ext: Bound per-task reenqueues and eject the owning scheduler
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3 with Andrea's Reviewed-by. The stale
enum_defs.autogen.h is refreshed by the following patch.

Thanks.

--
tejun
