Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B819C546
	for <sched-ext@lists.linux.dev>; Thu,  8 Jan 2026 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842631; cv=none; b=HMloD7SRITH1mVGTWLYVpzvS+aT9MUZMRnK3Vpl30hGd82A3dRna1SVTUMsInb5wYtc8nPsMZhd1DDFIuwu4MSOBzNqQoTIlolCPINv7vH6FdFDrjpjK+OdGsmIeomcwNhomoNTbr3z0Jj1CCEx1BmjAbd4UPgoOqqIbF44FJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842631; c=relaxed/simple;
	bh=VJz8rPL2xBgtlFEmngeXRA2pa8oEsAp6iYAiQhc9KVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ9oox2JhqC2x+gUkKwmm06PRhBO6JcFMdW461FzJegc9toIzcLq5wNwFLMDw+P3KjlWWYipr1DLn0vJ6BQz67MJpKltiXVS+YccJhqvAllT2iz9UI9CsIVk+GJ4yyAkSyCeXgCHtMNQpsD5RboF56qM2pURnTCPbPLqrYTRI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKrz1k20; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKrz1k20"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767842626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJz8rPL2xBgtlFEmngeXRA2pa8oEsAp6iYAiQhc9KVo=;
	b=mKrz1k20PJdd63FnW5hrv5ihcprvaXlrrvkeHOZFf2wlEGRHYjKBp1ajG0Uzr9T8UA+fnF
	K08uA2lKe4ltegdKrsGFCtjeKc895Rr5F9bub0PArqJFUqx9lgTDH4ZHD7RpOUiBdOjnCw
	bR9w94WTXqjlIuaDwemXkGB084RhnHU=
From: George Guo <dongtai.guo@linux.dev>
To: etsal@meta.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	dongtai.guo@linux.dev,
	guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com
Subject: Re: [PATCH 1/1] sched_ext: Add error logging for dsq creation failures
Date: Thu,  8 Jan 2026 11:23:28 +0800
Message-ID: <20260108032328.85947-1-dongtai.guo@linux.dev>
In-Reply-To: <BL1PR15MB531447D39DAACF121532E6A8C784A@BL1PR15MB5314.namprd15.prod.outlook.com>
References: <BL1PR15MB531447D39DAACF121532E6A8C784A@BL1PR15MB5314.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Etsal,
Thanks for reviewing!

> While the change looks correct, is there any benefit to it?
Yes, definitely. I found this issue while adding sched_ext support for
LoongArch. When scx_bpf_create_dsq() failed during my development, there
were no error messages at all, which made debugging difficult.

Specifically:
1. The failure was silent - no log, no error message in dmesg
2. I had to add bpf_printk() temporarily to confirm it was dsq creation failing

So the benefit is improved debuggability and faster issue diagnosis.

Thanks!

