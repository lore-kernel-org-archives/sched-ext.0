Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D92D1F40;
	Sun, 19 Apr 2026 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621188; cv=none; b=RDJeT8xSVvAL2qQ4DdXI908S37+T4iQazUlcRMCb4vm6F/oB0fhWKurxIqLTH0U+UO6p98gJ1fsb8j5ADMXf4t8Ds3tk6IGlJ/vmG9AzBjPu5aw2fZvg7u15qbI2ClXaOPiKBTuxa8QoDgI5uyKU+cQCgzpFIp2kJFqMhYf5po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621188; c=relaxed/simple;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iMs7aaw0EevRysEeo3fxU0s1d155zlfyZI4wFdH1QFSY82VLd/N/2Zd2+d98z1jxx8V2Kx9SEk7hxZ6fW/3FGlxN0454v9Ajuo9a6sJx8DkYgFg3M5LJ1kidXvgPH7A1oDmOcjKcMI0l6mq8tLT8eINcPEai168mdHMX259NG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwOMb6vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwOMb6vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975A3C2BCAF;
	Sun, 19 Apr 2026 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621187;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwOMb6vcsy2oXk8h1fu05NvimnYj93Wk3cQ+H/yXuzDdJYK7oBABV/ctP7ULH62cA
	 mfCRVT0PiYRzXZUiyQjC80Nw3qDmP9qaybAy3XKXTL1eQ/MXzucllQEz1wRLM2Iq0u
	 r75ZyYRNSB6q1f/TZwoSc7SQZhTj531fjRqfPaKblCP/Hji0M7GX9tq2h9lJPslFiS
	 LulD/JLqJqcuUIvaD+FWmSa4O8TKjgchT4tO3o4zyxL5MtMhnza8C6/3ads2pVNbAW
	 3P859lUHBnzQamGRxT29IeBkBK3Ts61290k6ZeeA53ZvoC2TcCIzbJikLqEVCZHOhJ
	 zuU6G5wy5ITEA==
Date: Sun, 19 Apr 2026 07:53:06 -1000
Message-ID: <ac4a939fb312285d5afacabad33240a2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Document the ops compat
 strategy in compat.h/compat.bpf.h
In-Reply-To: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
References: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

-- 
tejun
