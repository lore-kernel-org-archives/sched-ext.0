Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F63A1E80;
	Sun, 18 Oct 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304654; cv=none; b=HK3e363Kdhlma8a9RxlcncxfS1T10dtKt+2ycX/M262CIWobYFKhg9ychKWXg8Bloc6ftlg0X34lLDNWd5IE5apnBsFB8zBRwhsy2KNxJqRw4m4OZFcFtzcWmAgegj3sbfgHbUzqxDUuParMCs0deC8GDW2808HxhUuSlt9+5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304654; c=relaxed/simple;
	bh=kfqajJnz6Vz4il9Oe5BJNKl83aa4hZcOU5gr4udVkVQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WBufnJBDQSLObe5knWOAYkaJxsnc+RVlgWAb3qL7vX4jyavgl18GsaO0ebfVCFWGecwRchOvC0hLCRTRnQWJvE21nqxcw+hnYYXjdLkkwXXZ3RcvCVUC4sgmxi3qXrIlFRTasYxW2vIhCKlS+unnVFsooxCrPas89Fcbwy0ngWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME1GAmCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME1GAmCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085E91F000C4;
	Sun, 18 Oct 2026 06:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792304653;
	bh=kfqajJnz6Vz4il9Oe5BJNKl83aa4hZcOU5gr4udVkVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ME1GAmCK6wfN4SydKb2mGSMkgY4CLJdF0MOBUE/6BIgMgkPpzUN7Jq9WmSxNTm5Ts
	 alwKSXrqE6vywaQMKuElVIdO27kOQtk5XPT+RfcTaqC6ZrgDeDWozvyjVS0tXV+GzE
	 eF7irsLH1Xp3Vz8YBZ9LuYQwk+PoRBk3dPCPY6rDKnLPguS37RZeRTgLcpRK/1KkbQ
	 b4CvZ7qEoO1lO/FZkdhx0A72OnuYMuuYC7vIuqyPUjCRYQAb9HgAcxXYvCY0R4yDaB
	 zksiQEWX0CaMOMg7KpTejbfx8W8x5PAiy8uWkXMfnNH+r2J5QeNA/tJwOemgEX+qgh
	 4DvICi0CcL5oQ==
Date: Sat, 17 Oct 2026 20:24:12 -1000
Message-ID: <f142e8fb9d61dff037548268fab78d5c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Drop the locks periodically
 while walking a user DSQ for re-enqueue
In-Reply-To: <20261017235840.1446655-1-tj@kernel.org>
References: <20261017235840.1446655-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4 with the following tag added:

 Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
