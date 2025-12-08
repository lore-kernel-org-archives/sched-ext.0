Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E72ECD14;
	Mon,  8 Dec 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213954; cv=none; b=ITPTGgdKdIWLePrX2mLa+pi9oAgfOFrAorFl7PYmV0pWm6zvEBmsfEOdtt2wIygu3IKzdfXtpskLbSFkUadeFT++arb/Z6X+Kj5p9XkDnoz/5gL0kzqMAA1m+bI7LhjPXukrOR6mlXMBrcRwiBHnvm6dJPha/OKQ9f85/b3+GDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213954; c=relaxed/simple;
	bh=5Jm8yT2XdU9d6+ut3SK+JXWusH8XewNBkUr8eG8N0i4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NxQ7VMEp8VeJHFgbYXYGrbysZ5YFNXK6df083kKJUx+Q2pSZOkSywQ6nyNPpmlekND/qqbdGVC8JuxiPNEI/SNyxZtQ5hi3CHAt8I9bTlpYtrOBh2GRg7n36CtiMMwxiMzt62z4u3zjWVuFBFRLItrIxeLKAXyoUCVotk88cevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRErvWi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRErvWi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1857C4CEF1;
	Mon,  8 Dec 2025 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765213954;
	bh=5Jm8yT2XdU9d6+ut3SK+JXWusH8XewNBkUr8eG8N0i4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRErvWi/Zh54zSnr0bzqtqyOuIIUVVhLufnA1gc20RFzSoiUGkxGJD1KFJxbu1AvF
	 3HQWZeTagr5JIEq4sW25TI6jgEMeH3S8aiwDx5DvkwhzNDb36A+jfxkaTsYOsSo9Kb
	 fiOpjbmauTYhCFrLdd5Lk3flCH4+KSIRRMbW3Y/Rlwz/mHSlXPsZaO1lq7Qo9QLg3g
	 T6TOeVPih9v+Dlu4IhCyvJKN3W/e1qeC3I2URLeKaieQl/Cn+jTU/9PXjKwpZS0Y9d
	 HMyBlWghaTteHNbXSshF252PHUk3klhQjaXS5mieIzyYu6L3te8AZYyi++HIxlz7T8
	 eau1WJWI5USdQ==
Date: Mon, 08 Dec 2025 07:12:32 -1000
Message-ID: <208bd35b686b7a5eba618d458f175d08@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix the memleak for sch->helper objects
In-Reply-To: <20251208112320.27144-1-qiang.zhang@linux.dev>
References: <20251208112320.27144-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes with Fixes and stable tags.

Thanks.

--
tejun
