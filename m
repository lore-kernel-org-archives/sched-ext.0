Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998B55C317
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113518; cv=none; b=fGehT0PqS1sRt37I6pWAlQ1ylR7x30NEgaSlcs/TUMMt5R1c7aZHi3z2EGIqhfOwJIAUtwoY6uRCnaGybJMHuNSCtpZ/mmXqa9FAz8Vtmoyuet3g1FAPYgmNeV8fb78KlfAw2+ENUwFcSnhjO6vlqjr+l+8ScmRKm6/yKV9Bd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113518; c=relaxed/simple;
	bh=TbEs0g/ZGjMd40xECY43oMN6RbX63KSuMC9J84EANjc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T855zOYYTU+ZwCqW0ysuywKkk78DHt5S3mzszSTBHDd6SMPRDdx1VSQaXN+pdzQBVmvArbPdsGDdrkiP7OSnpU0Oqb+9PtjKz5ds6gmZLh8CO5vLWMzOp7zBS/wpwJZdjvx6FsV7tIWHtUR9CodiVewRPnZKFaPtkvHFb0i5Y6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMUxxbPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMUxxbPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E41F000FF;
	Tue, 22 Sep 2026 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790113504;
	bh=TbEs0g/ZGjMd40xECY43oMN6RbX63KSuMC9J84EANjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMUxxbPgA06C3SsfbEbU6DYgI9+yDXYQh3ap0CHV6XW1TK6rGmtrkWx1+uBzo48vQ
	 zqUAleXrriZdRMnztS152SXzxrTvoT4vSwrwN97iDlyQnXCs4SXXk6JHiNCAtgKKNH
	 +Br55j6v7CHTt4IHGeAqeIO5TGvHOuNLNLUCQWw8QtW9x/JdHcu5kN6CzbgR+V9im+
	 TF9J/HY86gN7iyzsXP8dGz5OmYXOTGNT1UEphe71YQyEue0d+KS+dbckRjIyVw2Ib1
	 Mi7WpPv0QFtLVEIOjtfDj8YlhQxVEWcCsClczT4w3MHnhP2I8k5xuXGtXEb3ukySC5
	 d+BRX++izkmLA==
Date: Tue, 22 Sep 2026 11:45:03 -1000
Message-ID: <5b216736cafe45f45f99f3c701f7575c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext for-7.4] selftests/sched_ext: Fix rt_stall runner abort
In-Reply-To: <20260922155037.17494-1-yphbchou0911@gmail.com>
References: <20260922155037.17494-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.
--
tejuns
