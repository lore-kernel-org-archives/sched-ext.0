Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD935908C2
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887389; cv=none; b=FCTHkEDd5bPxH39B9L/LH41Yxp5kab0DV6OIyY8rIc3VLkyOOjgAdx+GczrpR189sgMGmV2jP6NVShaPBfne5MhyYESAdVw49NzJLYdxL7KbG/Rv39eLudShhIWm3MDvnTRJNEoOwniTc3a4CcUtPoFs6qRSQJN15rIFjf9vroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887389; c=relaxed/simple;
	bh=Z8CvZByC//TlagVnzJ1kbN+/1HnpFgn28cZ2KIUcPX8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=i8h5EXNOKyC92dUYzOQx8pfrJu/Lzk1JA73qQhNnkiaZQks17S+LJ7kA+hfS7JaNgGacGG09/OYbb8hd51aeNnbTliwrtjapOudLz8YLaehCWR5uyuNPWLEomn7ElFj572tUbnbjhEueYpYkgUF89/0iQA6fRo5fFguarpxwzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djLEtYfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djLEtYfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDE1F00A3A;
	Tue,  8 Sep 2026 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887387;
	bh=Z8CvZByC//TlagVnzJ1kbN+/1HnpFgn28cZ2KIUcPX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djLEtYfU+LmS86Ew9FuJf28U5ExTuigeT+yLOPAtMRGxZPcbOzByPde4YqQVbnPMe
	 QH5H6F38Lv2Bhau6zn7rMMnvTXnXa0kY+QbNQbAWRviaaLRWTxwgu8JzsTdCuzy750
	 Go+Uz3I9uViqMXBTLAmMRz6IJ9SwX7666arnPdIGQHK9ldtxPWBS8BlZFk3/k+bCOw
	 mVJb0ixvGgJAprEl3K8+oOcPp7lsxwxg0M/Dty4IxYRDgFFFqRd5/tBRLSGvT1m7n2
	 ihataZULSVRasZlTarpxR/4t4pLfZJRdaAYq7mExAt3FCJLD43z4bkyB+4Pj9O9xu2
	 4fSzZIf97J5zQ==
Date: Tue, 08 Sep 2026 07:09:46 -1000
Message-ID: <ee978e5e8d76c75db0e7586d3175de83@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 chengyang.chou@mediatek.com
Subject: Re: [PATCH 1/2] tools/sched_ext: Drop the no-op -rdynamic from CFLAGS
In-Reply-To: <20260908134722.8671-2-yphbchou0911@gmail.com>
References: <20260908134722.8671-1-yphbchou0911@gmail.com>
 <20260908134722.8671-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Sep 08, 2026 at 09:47:08PM +0800, Cheng-Yang Chou wrote:
> Because CFLAGS only applies to compilation ($(CC) -c), the link-time
> flag -rdynamic is inert during the build. Schedulers do not rely on
> exported dynamic symbols, and binaries remain byte-identical without it.

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
