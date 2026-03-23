Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B11FB1;
	Mon, 23 Mar 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774224428; cv=none; b=fAdAfb7IWMqjRBeCGWta+wGwwtQ1DiJGVEijs/fEmIn/GqTVJBJfFafXNh3+Qe84G80f6amgUMGcP25B3LZeZ2NMDbvqXA11lg9SYorbnqkLeVsqDcmh6uO0/4YzeIlspAvM1464ItzVgEb0ToGsmSCqsqdOZPz8yIQ2+HRV+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774224428; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qQ+HqTeY8xQ0qpEgdOQd9cLC9qMPGWxeOHuarsKLxo7wEvYe0UYRYIuwpw0AaNa6TXxcpn4hdLI8WV2k1VeZpSNy8lAqIezRazCUNkGs2qJrSUqShEATCr8uRK9RVek9OsFhtJBe874me8uunYbVz+ioEVRKziPWjk5bxXEnLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/gBfki5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/gBfki5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0953AC19424;
	Mon, 23 Mar 2026 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774224428;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L/gBfki54k+MO6QdpS1vA/xFS6m9eIvqCHWnHwWesCof8KqH6Q8ZtLNrrESjQY+P+
	 tmSMG6d4sZ0ME1BeOtKWlhwT91n89gQ46h3Fzo30+vsVyA8CFsd5Or+pdFmPUdJOPs
	 K72gGi4lIglngQidbhv8YfDtwLyHFtt2EHWtxqb73zJu++9r8rd3P/WtUfgaj85Noc
	 NzgWvVvipw9W3TOv5qDFvpOyzoYek2wb2t3TFNrex9yU6v1P7BzTGxiFD/QDhMWo87
	 dBVaCJKLf5g3rPihXiYacn0z9LKEv7vINN1X8lM9p/bJr5swt2JaXvTKTdGs5EZVSR
	 sLLQm3dN3WlxQ==
Date: Sun, 22 Mar 2026 14:07:07 -1000
Message-ID: <8f758a05081df1d74aaec1ec1320e6a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Use irq_work_queue_on()
 in schedule_deferred()
In-Reply-To: <a80d84c345be8fbbd5a1294b9a72ae37@kernel.org>
References: <a80d84c345be8fbbd5a1294b9a72ae37@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
