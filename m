Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DE49BD75;
	Sat, 17 Oct 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275259; cv=none; b=cN2zao+ItrMdNJLcUSOOj7FKNUWR1xT/r4TNb4WdnQshKxkSyMqBA/7TrkugnZ3pLyNgkoOXL5xO1wshepF/Q9U8q8jumRARWVj/53UY4CUkLj7Rcxfj/PPFawQaIfjxUggMp3xbJVrZbkCSA4HmzpZMjT41EE6hAT9jDplJxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275259; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hfVyOLTWSPT0Bb8fEMqIB2gCoJUyzjMIZWXPUU8LI7qDiEXaJp9uTBdH697Z0tlJdP3cjFM8VCSiTnAfRra3/g7jVpEju1wK3LEUCrMPaZka2/qm3QtcHaACeNrFXjISwobVd65EmN+F58u0zikaO5c00MZjzA24b8+OOnrrGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2FhEsXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2FhEsXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B891F000C4;
	Sat, 17 Oct 2026 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792275258;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G2FhEsXW/20/vkAHcHte0pWIGritpCraEoy4UxVD0Tqd6+CHnQx+GxLtEMdNL/50i
	 kFnqfx0T+SRJB8vTB7ip/bnh/CZ+/Rkua4/Nihv5qrIMxMI+K4XfQ1UehppOLB1aJv
	 CEOjdKIGJgRIP3y5/3Bi1NAzyARD1b1SUrvQkjOKPSmjpvklwnleH8x4Q4I/8URqSl
	 GfwopLXHTH+71VqECx6dS+ah3vaRx//q20b9NAjRRFKOjLoTS/qn9hM2F/Uwobia46
	 va+BGKgYLtIq7mCjfyhB2YoKRQfqAew+chDuHIq7dCr0ROOhVg8aNQLL1KFsHVdXxP
	 F3SAmzbzdaz7g==
Date: Sat, 17 Oct 2026 12:14:17 -1000
Message-ID: <6681132130d7fc4742396c4103ecbf97@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Don't queue balance callbacks from a core-sched pick
In-Reply-To: <20261017202025.3834954-2-arighi@nvidia.com>
References: <20261017202025.3834954-1-arighi@nvidia.com>
 <20261017202025.3834954-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
