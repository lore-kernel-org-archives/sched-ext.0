Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBD4A5EBD;
	Wed, 16 Sep 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589317; cv=none; b=nSRWAWNSvjraOqJdSU0tJL9wKQgdFjcJiKJByS0av6NQo8Wwp6Ttd0KSxCO5fHR3nfIB8bUlf84dcfLs5/Y6eHM3DbxHocufT9MiR8UtCf0ePIDiThqYXi6USyVvEUO3m9ktdo0LQjJ41UPq4pOL2+W+qIU08jjk7B8LtDTNdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589317; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=urvzPLCzKjyHWm5bucVVGEWv1N8SaGCpjA32OTUNuKlHCcFcCmN3ysprguNXyP4Smzf1e9OiYeaE/yhcYMXmDeHs/TrKYKQZQ4wzLxcSkDxBBC3PTMVDcVay61kRKUeH051TkUYYTNPbV2maKaWVVFC/I4A+SfWZyvN10OAsrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnOcpoJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnOcpoJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4771F000FF;
	Wed, 16 Sep 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589304;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MnOcpoJnSTdfPIP2RB64Nmn5L1wWfXc5PouWNnKBd4XnVTE49Id52UGxt2oUp/AWc
	 LcFoWzZ5UQ8Ef3/d5SScgbSK+HtjAVDlF9jP2XUJSwAaFdM4D1tsBFATSin2uCeuPi
	 IkfVTI3HmC3KQZpRJYiXQsFX7BgmUSajgSKi75ukSSdYtLby2lYzVtksIzO4NjDFXn
	 1OodtCR4BMVVzXSLtuMs05da5jBDEqRlTd+bUHRXRAKJScNnudQbBybLtTNsa8X0tf
	 w66HGigydl8yt8ZaU7dLVc8ioDSZHUuHWZIovewgw7h5xqU8y1wxQSahm/kR6BR99H
	 JQZdE//WB8prQ==
Date: Wed, 16 Sep 2026 10:08:23 -1000
Message-ID: <9d43c95a17de1e53db7afd307713007f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Qiurong Fang <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Wait for
 SCX_OPSS_DISPATCHING before reenqueueing a task
In-Reply-To: <a4304b3f0c89fba23f1e5e92997a8f56@kernel.org>
References: <a4304b3f0c89fba23f1e5e92997a8f56@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
