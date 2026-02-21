Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06768283FC4;
	Sat, 21 Feb 2026 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771643987; cv=none; b=lCs+CdePGFSBg3iawoOue3Kf0VLDpuqX/+Mpz0DnO5GLdQCVd8mzP2R+PaYEmZhdW2EVxYfuG3L68Yh/wSbDgkyrAFvELTsMt0hLRSF5ahgl+RyLC0HXbwXWcsSSUU3OTSR+DAoq+3DzkHNA/G5QXuhMy9CsMrSLNQ6WQQjjL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771643987; c=relaxed/simple;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Yfpn7KrywV3NsGA1nED5D5GLfbSMdXhuI5qD6dfA9gA/9BZyQQ1p7cWoSGFkKZoWSgDdVUB/cjAxbhF+091rVnJHNntqG2JfGQFEgJRyPyZ8ToybUXKSwl9w9wTTDOV5Vx+hwuHxgfTFSnd+LYFxyhISL/99LIT7MR3XiPzUuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jszvkDnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jszvkDnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61600C19422;
	Sat, 21 Feb 2026 03:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771643986;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jszvkDnQe68wEJ+SEVFEM/d91h6Gl1fQHlCx4yfU9SEk2BXEY831VIZBP1vSDvrOg
	 Rg1V6+tPdINsGHKmAF90IQSLlT2EPCO3dO9v4dZNhTnMVWjQoC3/jFnOjKkxlAz4KK
	 +7R+nnhysDQwYTFrrDaCOnBEHHTJATDV70lCXaja1TMV1XQujkCHGWpjenwlskPiGd
	 izPo6HJyJJrx1rdU87XNgDkxAXxNigVgx7I1snelgfMJwNQUtxBAQsm39KtNu/tmo0
	 Xp13PW+hcGpzw04Ot60YgQ/BECZ5QvN50eGc+FLD+Iw1sF3mDIuxa354iWI0UHtIyI
	 u1KkKwDQtB/Iw==
Date: Fri, 20 Feb 2026 17:19:45 -1000
Message-ID: <a3ede64ce8231a05e1ce89f9209c0db8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: scx_userland: fix data races on
 shared counters
In-Reply-To: <20260218192223.8665-1-devnexen@gmail.com>
References: <20260218192223.8665-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.
--
tejun
