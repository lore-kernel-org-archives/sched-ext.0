Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA63BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381246; cv=none; b=YB6f3LFVVNUocGifZvCnNYtnox5b8tmAQOoK6qzlWnGvRqAFXJpoITBMtwmiKVJ6t0P+NsuHassBwJV26OLS4jlhn175WYRgJns+pIgL8ChIU5bUkMTwP8mQszJ5l+ueC6k/RFYOkk28w6mg8tr2m/Nztv/YiZbAMXLgaETSQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381246; c=relaxed/simple;
	bh=7QesUruqc+FIJInkd3DkDGSkaeIJFu0n7Nm8MfE+FEY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TYws763CySxJa7+BL7PtJjAQi781G//Ho/yTqZtXTWgxtjkzetgoO48Nu1e31OkWoTUZjbBjzLn+Uzkh8RH5e5DJRG1ZItAXH/w2TcsITWrc07fBDoIbn3ePpZlm40aMTx2Krrv+rf4Ct/VTPeSltWQqrD2ewlpbuBx3uttB4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je4iEaq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je4iEaq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AB71F00A3A;
	Mon,  6 Jul 2026 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381245;
	bh=7QesUruqc+FIJInkd3DkDGSkaeIJFu0n7Nm8MfE+FEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=je4iEaq/O1p84iCT/or2kverPXNrrsGTL0ZTo45XixXP2w75Cm1tr6RMNgP2xk4Hu
	 ENauuSgDwvyZ35ePphlKsxiEDlxi90zPb4msxc5Ad5udf8aFb91dtGi3qyIPUSJfbx
	 zhwo+PdSa4s3yJltkIxXIgvsFhmofvCe//ej5rdZiZ4k4QOrng7LxP4KioVv7IXqi8
	 4qLt20UxU4ZY2dH21D/9V9Mb51iopCzgzAF+EWVdJK9sIBpXi7jtWPfi4BiP4mmpRt
	 iEVTLUETl76+cj01SuGRqnlIZGPdCWYTN8SXZRmCkp9SmO4Bikv5rkF7RiwY/74Nx9
	 QjqIwj2j8/d+Q==
Date: Mon, 06 Jul 2026 13:40:44 -1000
Message-ID: <e5becc5d1b81b5e3d85cade27f51b681@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 20/36] sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
In-Reply-To: <20260706020627.2A7D41F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-21-tj@kernel.org> <20260706020627.2A7D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:06:24 +0000, sashiko-bot wrote:
> - [High] Missing private stack request for recursive BPF callback `sub_caps_updated` leads to kernel stack exhaustion and local DoS.

20-1 (recursive callback / private stack): confirmed, fixed for v3.
sub_caps_updated() now requests a private stack via bpf_scx_check_member(),
like ops.dispatch(). More generally, any recursion-capable op should request
one.

20-2 (no-arena NULL deref): false positive, same as the other no-arena
reports - cid-form requires an arena at load.
