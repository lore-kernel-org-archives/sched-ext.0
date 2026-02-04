Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1B1850A4;
	Wed,  4 Feb 2026 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243876; cv=none; b=u4YLc6NnayoxMUvS4S2sdXHMAWEvQJIhlaoKPWuO8p82GrntNGMey0L7FhIW/bqhBt9e4SWVOPm0H65z2aItUxF+w4sEqBwas4bZ0S+UJbzvmHZRasrBTWzuSQEYm9azUiyEAfezZoBL0FE6/F+ZEnMsD5kwiR9H5cH5newiJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243876; c=relaxed/simple;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=JuVgPSWD1yxQCzc03oAP4pXn/AqPwjuUTg2tCwodzOBqg3PPcqaeCXjkZcfFSgaPKd0oNDxJZkhyFtMQ2Jwy7K5nLADasWmQf67obropiu8b/uQI32X41+BRqcbg3Tp5BtrepjZSZFec+hP/hzawkB9SvzxviU84nCX+XVYjXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQBMvfG1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQBMvfG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B74C4CEF7;
	Wed,  4 Feb 2026 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770243876;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQBMvfG1ctVmjLk4lzhV9NYffX953fQef3Wbg2UhzxQil4WoABxHd1VkUQJzwLsti
	 X47w/kZ2u4iAAoEJqjpKl3qwd+08u7xlLjtbSkAlkzkd+pjwzs9T9U+MUh0UvvrKNZ
	 STEZaXHXCdTOCnJ40Goc4jy1npKQZhoKTN1w+vnFvralhleWOEsMvEF3AryVnB3oPS
	 WtqeK5/v0ccXMbYojpOmP5B8COnV2RiT2RxcsK/yryqHLjIDmHd5OlZlxjeAx/Gg/1
	 LWML4SpNAkVxSIPmyM/c7/TmkUY0TfJXGeAPrFG0/ygXHFl+olm9X/4KMaIEgPYOOu
	 fPSjsMwSuFokA==
Date: Wed, 04 Feb 2026 12:24:35 -1000
Message-ID: <93217677a8908060e011b075faa0b7d2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Short-circuit
 sched_class operations on dead tasks
In-Reply-To: <fc034891cef55029c16122f4279e4057@kernel.org>
References: <fc034891cef55029c16122f4279e4057@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.

--
tejun
