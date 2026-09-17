Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425645218A2;
	Thu, 17 Sep 2026 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665925; cv=none; b=hhkxdBBmpASbf7FpZaFMnrJQqF7rZU80PWvS67fEL0B1SK8ChOjZN5HG/18ZK0+2X0UrlBv3FcCG9AzrQ+49acONsbbJReMCNnpTpK22svbTz/BG9wn8wcG/PnIkPLBAPc6BUC64bVsRX/tvRLzVrJiduVRDdtokT6ChucNGhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665925; c=relaxed/simple;
	bh=N5RI8C416zldgS32puD+MEOkS+CstHszyDwEdsK2J5o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Dyd5dHEKT9/EALj+2dT2oZFTh/cN7eIvElIWnglxsz8mXEQJePf73FH/OSGiw2QLNIO8RZD86F1bqdHsDvF6xgO7KMIvM5NC0Ejnt51QD+rQFOvlzAD8q+6EOHn8/9Ih/IaB/+zZ+r9ksVh5ahZ26Ks3gjTAXH1HuLuwBJ54YyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTgTMKeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTgTMKeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7C1F000FF;
	Thu, 17 Sep 2026 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665924;
	bh=RN1RHrCXgVQo/M4TkLJYcpva2RPk9ccPqVouO6Wi830=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KTgTMKeVPG5YwUXAzYMFRDXz+I2MeogGlY8KbepA2XPCUGkioTB/JcEtRTBuwt6mp
	 H6bESi22zgDTdQPDu/x1og3izdx7fBJxeRYmEtrbwEgsLEoILbYKpYsoa2SDIOAKa2
	 ZTp/JyJ9zz79jN3g39MuKjEeSaSuL8+RotZ+TrCJRkt8gF2KIGLL9w/uD9avvYdpk3
	 zOKIGTnKWuNCCBjR6Y6JZc4/bf9TlmjYKt0phrwlA3O2cTaJVVgV2ClNMKjnNe7HBa
	 HY755SqjA73sBDAz3eco2IFOv7+rtrW+NZa2ZQljyFcMd3zmsUIRnET0yo1GXsPfO+
	 c+hZMFbGDvG0g==
Date: Thu, 17 Sep 2026 07:25:23 -1000
Message-ID: <092303008119c2c8ac55697b29ef1f06@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] sched_ext: Don't run ops.dequeue() with a DSQ lock
 held
In-Reply-To: <20260917075242.2813147-1-fangqiurong@kylinos.cn>
References: <20260917075242.2813147-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Thu, Sep 17, 2026 at 03:52:40PM +0800, Qiurong Fang wrote:
> fangqiurong (2):
>   sched_ext: Don't run ops.dequeue() with a DSQ lock held
>   selftests/sched_ext: Test that ops.dequeue() can iterate the consumed
>     DSQ

Applied 1-2 to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
