Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8743CE56
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744137; cv=none; b=NkpqouYTDDMV1gDgU5VXyJYLVrYzWwBKjd8O7WjzIgnj3swvJ2Zyym0fNiEmmxJ5jW9uXvY+iX9j6xGDgMx0aTw1gwAc6qkKYWTbw2qZsgy7OPLloN7U0kqeD09KAtGldrc9sQXpdGra1tMLfauaOAf4LWEmem5wvBSgrR+I0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744137; c=relaxed/simple;
	bh=QeirTZa+ZInwCWdGtdPXWzdYZcC+vfnMM4zqxXpyiSs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UgrLMA8wp9/GsbarfHF12oHnIIwAq4aONkzLy+R6fXZJMB6lFfHs2HCKTWtFPdWG/dGR6MndNpqkhakO/j40d9FJDOiJBrYtc0ln3pYuixgRXF0Y1YzEWS0JUj/1qkwejbfUsWySegzIrDpS5HxWID0xG1M43BzP5bPKEp4X4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcQzpAKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcQzpAKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3411F000E9;
	Wed, 22 Jul 2026 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784744136;
	bh=p1cKUlEHWZfOMyrCTjXgYBF0xBJIpeK382IuIqVj5hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JcQzpAKCu9jTFL5lfuptNgb4aAe8XV+oYfTf7kCPzvGp/vvYLiwx6H8pwMovxjuE7
	 2X2OjljFgUOK2/eLYXYN3rSH/POWuXuOs+H3ItUv4Rpc4iw77YSkiRJQhR9FerVrN2
	 A5cp89fd4xGOGXT0Z2D+FJaTOyc189UaXOXlvBUsyV7k2wbUx6G2nwjr4f32xVONPx
	 k59ANg2msCvf2RTmu9BOYnWpr5C1AvB7zrKvC1X0YSk4TOVNKTHsoRv9y41OkOuCvp
	 QXHY/LjoQnfrLB/7TPxVjVsT40QdoAZDSXCa99ItIpKhp/PVXya4UruEH0GH6FLORD
	 Cppe+D5AMKxug==
Date: Wed, 22 Jul 2026 08:15:35 -1000
Message-ID: <530db22c29b129622a775bd1b069148f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] tools/sched_ext: scx_pair: Convert to
 sched_switch TP
In-Reply-To: <20260719142917.34238-1-yphbchou0911@gmail.com>
References: <20260719142917.34238-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sun, Jul 19, 2026 at 10:28:45PM +0800, Cheng-Yang Chou wrote:
> ops.cpu_acquire/release() are deprecated in favor of tracking CPU
> preemption from a sched_switch tracepoint, see
> commit a3f5d4822253 ("sched_ext: Allow scx_bpf_reenqueue_local() to
> be called from anywhere"). Loading scx_pair currently emits a
> deprecation warning.

Applied to sched_ext/for-7.3.

Thanks.

-- 
tejun
