Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1133A71C
	for <sched-ext@lists.linux.dev>; Mon, 23 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869428; cv=none; b=sEqvDfTqw/21n2HGIytuTAfZyDYkOuiBqLP3ca7j7mMR/qMYWf09sAz8eZSgLUrtb6R6a+uvloEfsOgIFT7hJjzoF4ItNIj6oPDXdyN+38EyZmW24vHixMJt8QWwR1MDNWF8TBwE1Qa+Y+avq1ijiYnZwYT9cTv+3u9YZ1SR7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869428; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q336lnxNrT9k66sh9Bw8JDsioFzBwRsBe/7SYt6ab7sFtqzSrhpRpyhI+GRQzLOVS665l6sO0fwXxnkpwgGqM7s+jypRHErv0nsCiqy09A2i6sbKFG4C2HuIrmoCvmuTNrFJ75Kgidi/rhpvKKFiClR61IjDYRoq+B9jw1/E2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJKpmDdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJKpmDdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C79C2BCB0;
	Mon, 23 Feb 2026 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869428;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJKpmDdt0oUChmT2qiaPmMmYq0h7+naFGN9CZUPcNC3ZacxzqUhrcOr8mIbYmYK0d
	 tl3Xn43wQqfrP9dwoNW+l1ISGC6W2Prf/r4GI2/KL4zIwk4kZqDeF8RmVyLrXKOsgr
	 XP1nR5h8IxvefS8RLn/41cIipPsv6++g9ADsN9lF626nBh7EAe6W8XAfDp9e8Gi3kG
	 hRuj0taaBSnJ54AabkHhjoyN094V8X73CE+41wwC3Z77DwdPZwOLfkh4iI9UXWy2GE
	 scjNightAFI1y7LIaL1dph+2whNy92+fWbU8fDMq60l/0DcKkod7g4jXX2rIcUc7sR
	 bLJZ42uiGHlNA==
Date: Mon, 23 Feb 2026 07:57:07 -1000
Message-ID: <59b344dd66b01dc03ce17855d06b490e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] selftests/sched_ext: Remove duplicated unistd.h
 include in rt_stall.c
In-Reply-To: <20260222184709.99764-1-yphbchou0911@gmail.com>
References: <20260222184709.99764-1-yphbchou0911@gmail.com>
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
