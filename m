Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FD28CF5E;
	Mon, 15 Dec 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814252; cv=none; b=h1EUhSHsa+IPJYi+HrKdnCNRCBNf7VyDbLsbBaBBqONdfyhfvQKlsAhBEBjn3OIrXoZ2p1sK4frJBfYYdLxYHWmEQ7upLfWzuwoa9gozw297Re4Zy3lw05ThKdPYT7BjJRsupV3Q3hUuWLT5WSpTS19CSa6U+310jYP1/7agxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814252; c=relaxed/simple;
	bh=7eJ+/+pSOltw0wFxQMj+mHNcN0KU8LC4KKdG6ap31/Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=c/xA4OrLffPC+ZFHz9hWQKK7DS8efZX4HZALk1src7crv79BANR50l5y8nggUjekjpf2Hu71Qch/xvP82DeFk1ppQSw/6pR1a+zkGKfVDGgfGaYh7yKdCNpFrSNb0N+NjEm/Lfv4QPD7asuDzG13jOh9qFPiqkyQVL2CTyZXfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2kQrb8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2kQrb8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27760C4CEF5;
	Mon, 15 Dec 2025 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765814251;
	bh=7eJ+/+pSOltw0wFxQMj+mHNcN0KU8LC4KKdG6ap31/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2kQrb8r/0DCgGib+wtMvhC2++sFOO62ysVwryZYdq3qy55mOGJH25TmjPZ6tQTeO
	 ytu7kNJOH1+la7M04E6TRbfu+v+k1Ie0m1jlCZLP95eZx3ORcfWQH2yQxLxA7t13h0
	 r6dwvciyfg/iCbeoct6lqEctHPMGCh6MjC1Zo1ikvf+6/u4UJqbwHzn0BD5Oq4Fd0/
	 BeDZl8rw3MBD+b0f4pvKnLi41yktJUhJ0zYndrI+gM61ArCHmYDGobJ7k2TW9LzhWU
	 uLINRFxLg38UwU4+2QhbtJuTgUU1f+ZJ6WGwyJ4Gp+hicCAvkL8Ec5HHInH/jzFerZ
	 3OGxI2M3YBpNw==
Date: Mon, 15 Dec 2025 05:57:30 -1000
Message-ID: <0f96299a841c9d6cd8f9da0f26501f5a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Remove unused code in the do_pick_task_scx()
In-Reply-To: <20251215112940.23640-1-qiang.zhang@linux.dev>
References: <20251215112940.23640-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes with the Fixes tag (and trailing comma)
dropped.

Thanks.

--
tejun
