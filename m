Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A84EFFC3;
	Mon, 28 Sep 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613901; cv=none; b=Mdk9z47MOlZpmgPzF5YgwOFhmWiB3YUt0H5SQqOGsVyvLGUObWiLG+9X8KZtwb773+wns40qFdJIkiLLC9vnBs3/Fh6fqA6mQtqXvd1WVbHbd7Qj0AgwvDKD8tds4IRhJgH3fQkQBn9YY4xvY4zQbHeFaI8nMQlDZgQDYoNPJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613901; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iqZ+H6/w6yvnzv9pnVXgrY5VKpVOrXNEgsEvdvuMKFa+j4T7ncQx+dg70Pr/E2+3ONDxpjozMYDQOYbwCBg1hOUXoOjufE2qDSMaE3CU/KtuiU7TDZBdRmIMEIzgg+GONNvYs6hAtlHw5Xj+H8nqgTKdnGlyZ76qRlNJebhoh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFYbQqY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFYbQqY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873ED1F000FF;
	Mon, 28 Sep 2026 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613899;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iFYbQqY1nO6r0HPbUr3Oau2LbYvcu5XpusxrbeNNY/43NE1iGkndbi/IcYbtlU5oo
	 HOo67AEAQbWVWWNo+WSYgO9ja0u6OEpMGe78KEXNGOnU8sKdLrUX3nmTanUDVsaazI
	 2YvGD5uRwL3sjgc5ZMzmhMj9sk3cpyb3gEUBx788nRLgn9O6fiEaGgddq1k4qOJfMK
	 t+oJGwpDyTpjR7qEMSW5gR89qaZoNBGracKFx4H0S3ocJr+l1R02F+Uw4fX18NJ3P6
	 GMoHP1TlRYERjH/7Eebo+kAzela7HTmTvE77yQ6V7p0a1+fRlPEzpILfG6s42TPNXN
	 e6oN8GMFISlpw==
Date: Mon, 28 Sep 2026 06:44:58 -1000
Message-ID: <658555bf88cfc140f55ef862571be996@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Alap Mohan <mohaalap@meta.com>, Joonwoo Park <joonwoo@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix CPU hotplug
 hang when a dying CPU's tasks sit in the BPF scheduler
In-Reply-To: <20260923223825.734003-1-tj@kernel.org>
References: <20260923223825.734003-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
