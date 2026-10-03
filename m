Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E33B71B9;
	Sat,  3 Oct 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070909; cv=none; b=XGTbw1jDiaxEMNZfe12YT9d+2ViOQ7ChHaTqwbpAirOwBVewGAaZxYX+MqHrePTCzh4BzgmjntVTxjqkMWSgSyRNunDpb2gcV+9vme4FBwNllFMhNsel3gh7BW454nI5/1xI9C9Ukx9plX2ks4HVTrqCyqBVWd8HuTF51OzJ/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070909; c=relaxed/simple;
	bh=O+YdIaztVvdbIB0uhI2A8BE3SG6gPmcTtwfo+5+cPVg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=m6zLDBT7hrWXyST9kzL6o20fbnn7ny6TVISBrfvjqk3yDAfprhbtArh3cFCVTM7ZdAvMxvJA66QBOTb1FOZXIT2mnecsfzs669uUxFFSY8G8KLNMjxZY3l/POSqey0tI7EVHIeLx1T9jLuqlErr8OYA2li7/v6Zcpl3Ql7tXshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7wLgcoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7wLgcoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D81F0089B;
	Sat,  3 Oct 2026 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791070907;
	bh=WHn2+eSeQPDPJINwdeX2bB3R7JstPLwzgXUpdMV4UiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U7wLgcoLC/bC8nO+gyz5f5guufPKvppr64yPz3Dv9/osYNzoHE5b8Kt0zbYTnVcFl
	 fP53jjg4KWtc5FkVWsZu7pMaXYSHhM6fcAms/mGpATygK0qMQnI5fA2bUdftN42VAy
	 ARNWUSpfETYX9Asy6K1Rtiwn/O/5O82oioUjwUDWGhcV7y4r0NEumpZ+CuadgrRl14
	 hUjRbhHCLBqc3z5+G05xLpFVOyhVhM/iKKAgQOy9M3WPK/j6IpvjfEwhPPsLMI58y8
	 QhNwP4exZimgabcZ+Mksdin2rQVj6+zfK7jCmQuFkuVC4v5z9hK3/K66cFL4/mDGNb
	 ZewfrXkC2Oybw==
Date: Sat, 03 Oct 2026 13:41:46 -1000
Message-ID: <a3d7cb12303bcefcf53418bcab5bee26@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Generate qseq from
 a per-task counter
In-Reply-To: <20261003115317.43001-1-jpiecuch@google.com>
References: <20261003115317.43001-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes with the comment in scx_do_enqueue_task()
refilled and the following tag added:

    Cc: stable@vger.kernel.org # v6.12+

Thanks.

--
tejun
